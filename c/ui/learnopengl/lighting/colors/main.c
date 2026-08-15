#include <cglm/mat4.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <cglm/cglm.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include "shader.h"
#include "camera.h"

#define WIDTH 1280
#define HEIGHT 720

f32 lastX = F32(WIDTH) / 2.0;
f32 lastY = F32(HEIGHT) / 2.0;
bool first_mouse = true;
Camera *c;

f32 delta_time = 0.0;
f32 last_frame = 0.0;

vec3 light_pos = {1.2f, 1.0f, 2.0f};


void processInput(GLFWwindow *window);
void framebufferCallback(GLFWwindow *window, i32 width, i32 height);
void mousePosCallback(GLFWwindow *window, f64 xpos, f64 ypos);
void scrollCallback(GLFWwindow *window, f64 xoffset, f64 yoffset);


i32 main() {
  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");
  glfwInit();
  Camera tmp = cameraCreateVec((vec3){0.0, 0.0, 3.0});
  c = &tmp;
  
  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Colors", null, null);
  if (window == null) {
    glfwTerminate();
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  glfwSetFramebufferSizeCallback(window, framebufferCallback);
  glfwSetCursorPosCallback(window, mousePosCallback);
  glfwSetScrollCallback(window, scrollCallback);
  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
  
  glfwMakeContextCurrent(window);
  
  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
  glEnable(GL_DEPTH_TEST);

  f32 vertices[] = {
    -0.5f, -0.5f, -0.5f,
     0.5f, -0.5f, -0.5f,
     0.5f,  0.5f, -0.5f,
     0.5f,  0.5f, -0.5f,
    -0.5f,  0.5f, -0.5f,
    -0.5f, -0.5f, -0.5f,

    -0.5f, -0.5f,  0.5f,
     0.5f, -0.5f,  0.5f,
     0.5f,  0.5f,  0.5f,
     0.5f,  0.5f,  0.5f,
    -0.5f,  0.5f,  0.5f,
    -0.5f, -0.5f,  0.5f,

    -0.5f,  0.5f,  0.5f,
    -0.5f,  0.5f, -0.5f,
    -0.5f, -0.5f, -0.5f,
    -0.5f, -0.5f, -0.5f,
    -0.5f, -0.5f,  0.5f,
    -0.5f,  0.5f,  0.5f,

     0.5f,  0.5f,  0.5f,
     0.5f,  0.5f, -0.5f,
     0.5f, -0.5f, -0.5f,
     0.5f, -0.5f, -0.5f,
     0.5f, -0.5f,  0.5f,
     0.5f,  0.5f,  0.5f,
 
    -0.5f, -0.5f, -0.5f,
     0.5f, -0.5f, -0.5f,
     0.5f, -0.5f,  0.5f,
     0.5f, -0.5f,  0.5f,
    -0.5f, -0.5f,  0.5f,
    -0.5f, -0.5f, -0.5f,

    -0.5f,  0.5f, -0.5f,
     0.5f,  0.5f, -0.5f,
     0.5f,  0.5f,  0.5f,
     0.5f,  0.5f,  0.5f,
    -0.5f,  0.5f,  0.5f,
    -0.5f,  0.5f, -0.5f
  };

  Program cube_shader = programCreate("vertex.glsl", "fragment.glsl");
  if (cube_shader.id == 0) {
    LOG(ERROR, "programCreate failed");
    goto EXIT_ERROR;
  }
  Program light_shader = programCreate("light_vertex.glsl", "light_fragment.glsl");
  if (light_shader.id == 0) {
    LOG(ERROR, "programCreate failed");
    goto EXIT_ERROR;
  }

  u32 cubeVAO, lightVAO, VBO;

  glGenVertexArrays(1, &cubeVAO);
  glGenVertexArrays(1, &lightVAO);
  glGenBuffers(1, &VBO);

  glBindVertexArray(cubeVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);


  glBindVertexArray(lightVAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  while(!glfwWindowShouldClose(window)) {
    f32 current_frame = F32(glfwGetTime());
    delta_time = current_frame - last_frame;
    last_frame = current_frame;
    processInput(window);

    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    programUse(cube_shader);
    vec3 objectColor = {1.0f, 0.5f, 0.31f};
    vec3 lightColor = {1.0, 1.0, 1.0};
    mat4 projection = GLM_MAT4_IDENTITY_INIT;
    glm_perspective(glm_rad(c->zoom), F32(WIDTH) / F32(HEIGHT), 0.1f, 100.f, projection);
    mat4 view = GLM_MAT4_IDENTITY_INIT;
    cameraGetViewMatrix(c, view);
    mat4 model = GLM_MAT4_IDENTITY_INIT;
    programSetUniformVec3(cube_shader, "objectColor", objectColor);
    programSetUniformVec3(cube_shader, "lightColor", lightColor);
    programSetUniformMat4(cube_shader, "projection", projection);
    programSetUniformMat4(cube_shader, "view", view);
    programSetUniformMat4(cube_shader, "model", model);

    glBindVertexArray(cubeVAO);
    glDrawArrays(GL_TRIANGLES, 0, 36);

    programUse(light_shader);
    programSetUniformMat4(light_shader, "projection", projection);
    programSetUniformMat4(light_shader, "view", view);
    mat4 light_model = GLM_MAT4_IDENTITY_INIT;
    glm_translate(light_model, light_pos);
    glm_scale(light_model, (vec3){0.2f, 0.2f, 0.2f});
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

 EXIT_ERROR:
  glfwDestroyWindow(window);
  glfwTerminate();
  logCleanup();
  return 0;
}

void processInput(GLFWwindow *window) {
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

void mousePosCallback(GLFWwindow *window, f64 xpos_in, f64 ypos_in) {
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
