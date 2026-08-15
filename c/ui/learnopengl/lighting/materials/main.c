#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>
#include <cglm/cglm.h>
#include <GLFW/glfw3.h>

#include "shader.h"
#include "camera.h"


#define WIDTH 1280
#define HEIGHT 720

Camera *c;
f32 lastX = 0.0;
f32 lastY = 0.0;
f32 delta_time = 0.0;
f32 last_frame = 0.0;
bool first_mouse = true;

vec3 light_pos = {1.2, 1.0, 2.0};

void procesInput(GLFWwindow *window);
void framebufferCallback(GLFWwindow *window, i32 width, i32 height);
void mouseposCallback(GLFWwindow *window, f64 xpos_in, f64 ypos_in);
void scrollCallback(GLFWwindow *window, f64 xoffset, f64 yoffset);

i32 main() {

  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");
  Camera cam = cameraCreateVec((vec3){0.0, 0.0, 3.0});
  c = &cam;

  glfwInit();

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Basic lighting", null, null);
  if (window == null) {
    LOG(ERROR, "glfwCreateWindow falied");
    glfwTerminate();
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_CAPTURED);

  glfwMakeContextCurrent(window);

  glfwSetFramebufferSizeCallback(window, framebufferCallback);
  glfwSetCursorPosCallback(window, mouseposCallback);
  glfwSetScrollCallback(window, scrollCallback);

  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
  glEnable(GL_DEPTH_TEST);
  LOG(INFO, "Init glfw and OpenGL");

  Program cube_shader = programCreate("./cube_vertex.glsl", "./cube_fragment.glsl");
  if (cube_shader.id == 0) {
    LOG(ERROR, "Load cube shader faelid");
    exit(1);
  }

  Program light_shader = programCreate("./light_vertex.glsl", "./light_fragment.glsl");
  if (light_shader.id == 0) {
    LOG(ERROR, "Load light shader failed");
    exit(1);
  }

  LOG(INFO, "Load shaders");


  f32 vertices[] = {
    -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f,
     0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f, 
     0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f, 
     0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f, 
    -0.5f,  0.5f, -0.5f,  0.0f,  0.0f, -1.0f, 
    -0.5f, -0.5f, -0.5f,  0.0f,  0.0f, -1.0f, 

    -0.5f, -0.5f,  0.5f,  0.0f,  0.0f, 1.0f,
     0.5f, -0.5f,  0.5f,  0.0f,  0.0f, 1.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  0.0f, 1.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  0.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,  0.0f,  0.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,  0.0f,  0.0f, 1.0f,

    -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,
    -0.5f,  0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
    -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
    -0.5f, -0.5f, -0.5f, -1.0f,  0.0f,  0.0f,
    -0.5f, -0.5f,  0.5f, -1.0f,  0.0f,  0.0f,
    -0.5f,  0.5f,  0.5f, -1.0f,  0.0f,  0.0f,

     0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,
     0.5f,  0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
     0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
     0.5f, -0.5f, -0.5f,  1.0f,  0.0f,  0.0f,
     0.5f, -0.5f,  0.5f,  1.0f,  0.0f,  0.0f,
     0.5f,  0.5f,  0.5f,  1.0f,  0.0f,  0.0f,

    -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,
     0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,
     0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
     0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, -1.0f,  0.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, -1.0f,  0.0f,

    -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,
     0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
     0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
    -0.5f,  0.5f,  0.5f,  0.0f,  1.0f,  0.0f,
    -0.5f,  0.5f, -0.5f,  0.0f,  1.0f,  0.0f
  };


  u32 cubeVAO, lightVAO, VBO;
  glGenVertexArrays(1, &cubeVAO);
  glGenVertexArrays(1, &lightVAO);
  glGenBuffers(1, &VBO);

  glBindVertexArray(cubeVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(f32), (void *)(3 * sizeof(f32)));
  glEnableVertexAttribArray(1);

  glBindVertexArray(lightVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  while(!glfwWindowShouldClose(window)) {
    f32 current_frame = F32(glfwGetTime());
    delta_time = current_frame - last_frame;
    last_frame = current_frame;
    
    procesInput(window);
    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);


    programUse(cube_shader);

    programSetUniformVec3(cube_shader, "light.position", light_pos);
    programSetUniformVec3(cube_shader, "viewPos", c->position);

    vec3 light_color;
    light_color[0] = F32(sin(glfwGetTime() * 2.0));
    light_color[1] = F32(sin(glfwGetTime() * 0.7));
    light_color[2] = F32(sin(glfwGetTime() * 1.3));
    vec3 diffuse_color;
    glm_vec3_mul(light_color, (vec3){0.5, 0.5, 0.5}, diffuse_color);
    vec3 ambient_color;
    glm_vec3_mul(diffuse_color, (vec3){0.2, 0.2, 0.2}, ambient_color);
    programSetUniformVec3(cube_shader, "light.ambient", ambient_color);
    programSetUniformVec3(cube_shader, "light.diffuse", diffuse_color);
    programSetUniformVec3(cube_shader, "light.specular", (vec3){1.0, 1.0, 1.0});

    programSetUniformVec3(cube_shader, "material.ambient", (vec3){1.0, 0.5, 0.31});
    programSetUniformVec3(cube_shader, "material.diffuse", (vec3){1.0, 0.5, 0.31});
    programSetUniformVec3(cube_shader, "material.specular", (vec3){0.5, 0.5, 0.5});
    programSetUniformFloat(cube_shader, "material.shininess", 32.0);

    mat4 projection = GLM_MAT4_IDENTITY_INIT;
    glm_perspective(glm_rad(c->zoom), F32(WIDTH) / F32(HEIGHT), 0.1, 100.0, projection);
    mat4 view = GLM_MAT4_IDENTITY_INIT;
    cameraGetViewMatrix(c, view);
    mat4 model = GLM_MAT4_IDENTITY_INIT;
    programSetUniformMat4(cube_shader, "projection", projection);
    programSetUniformMat4(cube_shader, "view", view);
    programSetUniformMat4(cube_shader, "model", model);

    glBindVertexArray(cubeVAO);
    glDrawArrays(GL_TRIANGLES, 0, 36);

    programUse(light_shader);
    programSetUniformMat4(light_shader, "projection", projection);
    programSetUniformMat4(light_shader, "view", view);
    mat4 light_model = GLM_MAT4_IDENTITY_INIT;
    // light_pos[0] = sin(F32(glfwGetTime()));
    // light_pos[1] = cos(F32(glfwGetTime()));
    // light_pos[2] = cos(F32(glfwGetTime()));
    glm_translate(light_model, light_pos);
    glm_scale(light_model, (vec3){0.2, 0.2, 0.2});
    programSetUniformMat4(light_shader, "model", light_model);


    glBindVertexArray(lightVAO);
    glDrawArrays(GL_TRIANGLES, 0, 36);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glDeleteVertexArrays(1, &cubeVAO);
  glDeleteVertexArrays(1, &lightVAO);
  glDeleteBuffers(1, &VBO);
  programDestroy(cube_shader);
  programDestroy(light_shader);


  glfwDestroyWindow(window);
  glfwTerminate();
  logCleanup();


  return 0;
}

void procesInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
  if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
    cameraProcessKeyboard(c, FORWARD, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
    cameraProcessKeyboard(c, BACKWARD, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
    cameraProcessKeyboard(c, LEFT, delta_time);
  }
  if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
    cameraProcessKeyboard(c, RIGHT, delta_time);
  }
}

void framebufferCallback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}

void mouseposCallback(GLFWwindow *window, f64 xpos_in, f64 ypos_in) {
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
  cameraProcessMouseMovement(c, xoffset, yoffset, true);
}

void scrollCallback(GLFWwindow *window, f64 xoffset, f64 yoffset) {
  cameraProcessMouseScroll(c, F32(yoffset));
}
