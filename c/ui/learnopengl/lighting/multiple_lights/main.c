#include <cglm/mat4.h>
#include <cglm/util.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include "camera.h"
#include "texture.h"
#include "shader.h"
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <cglm/cglm.h>




#define WIDTH 1280
#define HEIGHT 720
Camera *cam;
vec3 light_pos;
f32 lastX = 0;
f32 lastY = 0;
f32 delta_time = 0;
f32 last_frame = 0;
bool first_mouse = true;


void framebuffer_callback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}

void mouse_callback(GLFWwindow *window, f64 xpos_in, f64 ypos_in) {
  f32 xpos = F32(xpos_in);
  f32 ypos = F32(ypos_in);

  if (first_mouse) {
    lastX = xpos;
    lastY = ypos;
    first_mouse = false;
  }

  f32 xoffset = xpos - lastX;
  f32 yoffset = lastY - ypos;
  lastX = xpos;
  lastY = ypos;

  cameraProcessMouseMovement(cam, xoffset, yoffset, true);
}

void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset) {
  cameraProcessMouseScroll(cam, F32(yoffset));
}

void process_input(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
  if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
    cameraProcessKeyboard(cam, FORWARD, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
    cameraProcessKeyboard(cam, BACKWARD, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
    cameraProcessKeyboard(cam, LEFT, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
    cameraProcessKeyboard(cam, RIGHT, delta_time);
  }
}

i32 main() {
  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");
  glfwInit();

  Camera tmp = cameraCreateVec((vec3){0.0, 0.0, 3.0});
  cam = &tmp;

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Multiple lights", null, null);
  if (window == null) {
    LOG(ERROR, "glfwCreateWindow error");
    glfwTerminate();
    return 1;
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);

  glfwMakeContextCurrent(window);
  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  glEnable(GL_DEPTH_TEST);

  glfwSetFramebufferSizeCallback(window, framebuffer_callback);
  glfwSetCursorPosCallback(window, mouse_callback);
  glfwSetScrollCallback(window, scroll_callback);


  LOG(INFO, "Init glfw and OpenGL");

  Shader cube_shader = shaderCreate("cube_vertex.glsl", "cube_fragment.glsl");
  if (cube_shader.id == 0) {
    LOG(ERROR, "Load cube shader error");
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }
  Shader light_shader = shaderCreate("light_vertex.glsl", "cube_fragment.glsl");
  if (light_shader.id == 0) {
    LOG(ERROR, "Load light shader error");
    shaderDestroy(cube_shader);
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  Texture diffuse_map = textureLoad("container2.png");
  if (diffuse_map.id == 0) {
    LOG(ERROR, "Load diffuse_map texture error");
    return 1;
  }
  Texture specular_map = textureLoad("container2_specular.png");
  if (specular_map.id == 0) {
    LOG(ERROR, "Load specular_map texture error");
    return 1;
  }

  LOG(INFO, "Load shaders and texutres");



  f32 vertices[] = {
     -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  0.0f,  0.0f,
      0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  1.0f,  0.0f,
      0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  1.0f,  1.0f,
      0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  1.0f,  1.0f,
     -0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  0.0f,  1.0f,
     -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,  0.0f,  0.0f,
     -0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  0.0f,  0.0f,
      0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  1.0f,  0.0f,
      0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  1.0f,  1.0f,
      0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  1.0f,  1.0f,
     -0.5f,  0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  0.0f,  1.0f,
     -0.5f, -0.5f,  0.5f,  0.0f,  0.0f,  1.0f,  0.0f,  0.0f,
     -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,  1.0f,  0.0f,
     -0.5f,  0.5f, -0.5f, -1.0f,  0.0f,  0.0f,  1.0f,  1.0f,
     -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
     -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
     -0.5f, -0.5f,  0.5f, -1.0f,  0.0f,  0.0f,  0.0f,  0.0f,
     -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,  1.0f,  0.0f,
      0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,  1.0f,  0.0f,
      0.5f,  0.5f, -0.5f,  1.0f,  0.0f,  0.0f,  1.0f,  1.0f,
      0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
      0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,  0.0f,  1.0f,
      0.5f, -0.5f,  0.5f,  1.0f,  0.0f,  0.0f,  0.0f,  0.0f,
      0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,  1.0f,  0.0f,
     -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,  0.0f,  1.0f,
      0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,  1.0f,  1.0f,
      0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,  1.0f,  0.0f,
      0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,  1.0f,  0.0f,
     -0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,  0.0f,  0.0f,
     -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,  0.0f,  1.0f,
     -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,  0.0f,  1.0f,
      0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,  1.0f,  1.0f,
      0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,  1.0f,  0.0f,
      0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,  1.0f,  0.0f,
     -0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,  0.0f,  0.0f,
     -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,  0.0f,  1.0f
  };

  vec3 cube_positions[] = {
    { 0.0f,  0.0f,  0.0f},
    { 2.0f,  5.0f, -15.0f},
    {-1.5f, -2.2f, -2.5f},
    {-3.8f, -2.0f, -12.3f},
    { 2.4f, -0.4f, -3.5f},
    {-1.7f,  3.0f, -7.5f},
    { 1.3f, -2.0f, -2.5f},
    { 1.5f,  2.0f, -2.5f},
    { 1.5f,  0.2f, -1.5f},
    {-1.3f,  1.0f, -1.5}};

  
  vec3 pointLightPositions[] = {
    { 0.7f,  0.2f,  2.0f},
    { 2.3f, -3.3f, -4.0f},
    {-4.0f,  2.0f, -12.0f},
    { 0.0f,  0.0f, -3.0}};


  u32 cubeVAO, lightVAO, VBO;
  glGenVertexArrays(1, &cubeVAO);
  glGenVertexArrays(1, &lightVAO);
  glGenBuffers(1, &VBO);
  glBindVertexArray(cubeVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)(3 * sizeof(f32)));
  glEnableVertexAttribArray(1);
  glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)(6 * sizeof(f32)));
  glEnableVertexAttribArray(2);

  glBindVertexArray(lightVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);


  shaderUse(cube_shader);
  shaderSetUniformInt(cube_shader, "material.diffuse", 0);
  shaderSetUniformInt(cube_shader, "material.specular", 1);
  


  while(!glfwWindowShouldClose(window)) {
    f32 current_frame = F32(glfwGetTime());
    delta_time = current_frame - last_frame;
    last_frame = current_frame;

    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    process_input(window);

    shaderSetUniformVec3(cube_shader, "viewPos", cam->position);
    shaderSetUniformFloat(cube_shader, "material.shininess", 32.0);

    //directional light
    shaderSetUniformVec3(cube_shader, "dirLight.direction", (vec3){-0.2f, -1.0f, -0.3f});
    shaderSetUniformVec3(cube_shader, "dirLight.ambient", (vec3){0.05f, 0.05f, 0.05f});
    shaderSetUniformVec3(cube_shader, "dirLight.diffuse", (vec3){0.4f, 0.4f, 0.4f});
    shaderSetUniformVec3(cube_shader, "dirLight.specular", (vec3){0.5f, 0.5f, 0.5f});
    // point light 1
    shaderSetUniformVec3(cube_shader, "pointLights[0].position", pointLightPositions[0]);
    shaderSetUniformVec3(cube_shader, "pointLights[0].ambient", (vec3){0.05f, 0.05f, 0.05f});
    shaderSetUniformVec3(cube_shader, "pointLights[0].diffuse", (vec3){0.8f, 0.8f, 0.8f});
    shaderSetUniformVec3(cube_shader, "pointLights[0].specular",(vec3){ 1.0f, 1.0f, 1.0f});
    shaderSetUniformFloat(cube_shader, "pointLights[0].constant", 1.0f);
    shaderSetUniformFloat(cube_shader, "pointLights[0].linear", 0.09f);
    shaderSetUniformFloat(cube_shader, "pointLights[0].quadratic", 0.032f);
    // point light 2
    shaderSetUniformVec3(cube_shader, "pointLights[1].position", pointLightPositions[1]);
    shaderSetUniformVec3(cube_shader, "pointLights[1].ambient", (vec3){0.05f, 0.05f, 0.05f});
    shaderSetUniformVec3(cube_shader, "pointLights[1].diffuse", (vec3){0.8f, 0.8f, 0.8f});
    shaderSetUniformVec3(cube_shader, "pointLights[1].specular",(vec3){ 1.0f, 1.0f, 1.0f});
    shaderSetUniformFloat(cube_shader, "pointLights[1].constant", 1.0f);
    shaderSetUniformFloat(cube_shader, "pointLights[1].linear", 0.09f);
    shaderSetUniformFloat(cube_shader, "pointLights[1].quadratic", 0.032f);
    // point light 3
    shaderSetUniformVec3(cube_shader, "pointLights[2].position", pointLightPositions[2]);
    shaderSetUniformVec3(cube_shader, "pointLights[2].ambient", (vec3){0.05f, 0.05f, 0.05f});
    shaderSetUniformVec3(cube_shader, "pointLights[2].diffuse", (vec3){0.8f, 0.8f, 0.8f});
    shaderSetUniformVec3(cube_shader, "pointLights[2].specular",(vec3){ 1.0f, 1.0f, 1.0f});
    shaderSetUniformFloat(cube_shader, "pointLights[2].constant", 1.0f);
    shaderSetUniformFloat(cube_shader, "pointLights[2].linear", 0.09f);
    shaderSetUniformFloat(cube_shader, "pointLights[2].quadratic", 0.032f);
    // point light 4
    shaderSetUniformVec3(cube_shader, "pointLights[3].position", pointLightPositions[3]);
    shaderSetUniformVec3(cube_shader, "pointLights[3].ambient", (vec3){0.05f, 0.05f, 0.05f});
    shaderSetUniformVec3(cube_shader, "pointLights[3].diffuse", (vec3){0.8f, 0.8f, 0.8f});
    shaderSetUniformVec3(cube_shader, "pointLights[3].specular",(vec3){ 1.0f, 1.0f, 1.0f});
    shaderSetUniformFloat(cube_shader, "pointLights[3].constant", 1.0f);
    shaderSetUniformFloat(cube_shader, "pointLights[3].linear", 0.09f);
    shaderSetUniformFloat(cube_shader, "pointLights[3].quadratic", 0.032f);
    // spotLight
    shaderSetUniformVec3(cube_shader, "spotLight.position", cam->position);
    shaderSetUniformVec3(cube_shader, "spotLight.direction", cam->front);
    shaderSetUniformVec3(cube_shader, "spotLight.ambient", (vec3){0.0f, 0.0f, 0.0f});
    shaderSetUniformVec3(cube_shader, "spotLight.diffuse", (vec3){1.0f, 1.0f, 1.0f});
    shaderSetUniformVec3(cube_shader, "spotLight.specular",(vec3){ 1.0f, 1.0f, 1.0f});
    shaderSetUniformFloat(cube_shader, "spotLight.constant", 1.0f);
    shaderSetUniformFloat(cube_shader, "spotLight.linear", 0.09f);
    shaderSetUniformFloat(cube_shader, "spotLight.quadratic", 0.032f);
    shaderSetUniformFloat(cube_shader, "spotLight.cutOff", cos(glm_rad(12.5f)));
    shaderSetUniformFloat(cube_shader, "spotLight.outerCutOff", cos(glm_rad(15.0f)));

    mat4 projection = GLM_MAT4_IDENTITY_INIT;
    glm_perspective(glm_rad(cam->zoom), F32(WIDTH) / F32(HEIGHT), 0.1, 100.0, projection);
    mat4 view = GLM_MAT4_IDENTITY_INIT;
    cameraGetViewMatrix(cam, view);
    shaderSetUniformMat4(cube_shader, "projection", projection);
    shaderSetUniformMat4(cube_shader, "view", view);

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, diffuse_map.id);
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, specular_map.id);

    glBindVertexArray(cubeVAO);
    for(i32 i = 0; i < 10; i++) {
      mat4 model = GLM_MAT4_IDENTITY_INIT;
      glm_translate(model, cube_positions[i]);
      f32 angle = 20.0 * i;
      glm_rotate(model, glm_rad(angle), (vec3){1.0, 0.3, 0.5});
      shaderSetUniformMat4(cube_shader, "model", model);

      glDrawArrays(GL_TRIANGLES, 0, 36);
    }

    shaderUse(light_shader);
    shaderSetUniformMat4(light_shader, "projection", projection);
    shaderSetUniformMat4(light_shader, "view", view);

    glBindVertexArray(lightVAO);
    for(i32 i = 0; i < 4; i++) {
      mat4 model = GLM_MAT4_IDENTITY_INIT;
      glm_translate(model, pointLightPositions[i]);
      glm_scale(model, (vec3){0.2, 0.2, 0.2});
      shaderSetUniformMat4(light_shader, "model", model);

      glDrawArrays(GL_TRIANGLES, 0, 36);
    }

    glfwSwapBuffers(window);
    glfwPollEvents();
  }
  

  shaderDestroy(light_shader);
  shaderDestroy(cube_shader);
  glfwDestroyWindow(window);
  glfwTerminate();
  logCleanup();
  return 0;
}

