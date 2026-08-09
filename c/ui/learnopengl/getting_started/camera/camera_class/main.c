#include <cglm/vec3.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <cstdext/core.h>
#include "shader.h"
#include "texture.h"
#include "camera.h"
#include <cglm/cglm.h>

#define WIDTH 1280
#define HEIGHT 720

void framebufferCallback(GLFWwindow *window, i32 width, i32 height);
void mouseCallback(GLFWwindow *window, f64 xpos, f64 ypos);
void scrollCallback(GLFWwindow *window, f64 xoffset, f64 yoffset);
void processInput(GLFWwindow *window);

Camera *c;

bool first_mouse = true;

f32 delta_time = 0.0;
f32 last_frame = 0.0;
f32 lastX = F32(WIDTH) / 2.0f;
f32 lastY = F32(HEIGHT) / 2.0f;


i32 main() {
  glfwInit();
  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");

  Camera tmp = cameraCreateVec((vec3){0.0f, 0.0f, 3.0f});
  c = &tmp;
  
  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Camera example", null, null);
  if (window == null) {
    LOG(ERROR, "glfwCreateWindow error");
    glfwTerminate();
    return 1;
  }
  LOG(INFO, "Init glfw and create WINDOW");

  glfwWindowHint(GL_MAJOR_VERSION, 3);
  glfwWindowHint(GL_MINOR_VERSION, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);

  glfwSetFramebufferSizeCallback(window, framebufferCallback);
  glfwSetCursorPosCallback(window, mouseCallback);
  glfwSetScrollCallback(window, scrollCallback);

  
  glfwMakeContextCurrent(window);

  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  glEnable(GL_DEPTH_TEST);

  Program prog = programCreate("vertex.glsl", "fragment.glsl");

  f32 vertices[] = {
    -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,
     0.5f, -0.5f, -0.5f,  1.0f, 0.0f,
     0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
     0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
    -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,

    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
     0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
     0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
     0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,

    -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
    -0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
    -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

     0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
     0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
     0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
     0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
     0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
     0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
 
    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
     0.5f, -0.5f, -0.5f,  1.0f, 1.0f,
     0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
     0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
    -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,

    -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
     0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
     0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
     0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
    -0.5f,  0.5f,  0.5f,  0.0f, 0.0f,
    -0.5f,  0.5f, -0.5f,  0.0f, 1.0f
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
   {-1.3f,  1.0f, -1.5f}
  };

  u32 VBO, VAO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);
  glBindVertexArray(VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)(3 * sizeof(f32)));
  glEnableVertexAttribArray(1);

  Texture t1 = textureLoadJpg("container.jpg");
  if (t1.id == 0) {
    glfwDestroyWindow(window);
    glfwTerminate();
    programDestroy(prog);
    return 1;
  }
  Texture t2 = textureLoadPng("awesomeface.png");
  if (t2.id == 0) {
    glfwDestroyWindow(window);
    glfwTerminate();
    textureDestroy(t1);
    programDestroy(prog);
    return 1;
  }
  LOG(INFO, "Load textures");

  programUse(prog);
  programSetUniformInt(prog, "texture1", 0);
  programSetUniformInt(prog, "texture2", 1);

  LOG(INFO, "Enter main loop");

  while(!glfwWindowShouldClose(window)) {
    processInput(window);
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    f32 current_frame = F32(glfwGetTime());
    delta_time = current_frame - last_frame;
    last_frame = current_frame;

    glActiveTexture(GL_TEXTURE0);
    textureBind(t1);
    glActiveTexture(GL_TEXTURE1);
    textureBind(t2);

    programUse(prog);

    mat4 projection = GLM_MAT4_IDENTITY_INIT;
    glm_perspective(glm_rad(c->zoom), F32(WIDTH) / F32(HEIGHT), 0.1f, 100.0f, projection);
    programSetUniformMat4(prog, "projection", projection);

    mat4 view = GLM_MAT4_IDENTITY_INIT;
    cameraGetViewMatrix(c, view);
    programSetUniformMat4(prog, "view", view);

    glBindVertexArray(VAO);

    for(i32 i = 0; i < 10; i++) {
      mat4 model = GLM_MAT4_IDENTITY_INIT;
      glm_translate(model, cube_positions[i]);
      glm_rotate(model, sin(F32(glfwGetTime())) * i, (vec3){1.0f, 0.3f, 0.5f});
      programSetUniformMat4(prog, "model", model);

      glDrawArrays(GL_TRIANGLES, 0, 36);
    }


    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  programDestroy(prog);
  textureDestroy(t1);
  textureDestroy(t2);
  glDeleteVertexArrays(1, &VAO);
  glDeleteBuffers(1, &VBO);
  glfwDestroyWindow(window);
  glfwTerminate();

  LOG(INFO, "Cleanup and end of OpenGL");
  logCleanup();
  return 0;
}

void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
  float camera_speed = 2.5 * delta_time;
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

void mouseCallback(GLFWwindow *window, f64 xposin, f64 yposin) {
  f32 xpos = F32(xposin);
  f32 ypos = F32(yposin);

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
