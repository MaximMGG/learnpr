#include <stdio.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "../lib/util.h"
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include "camera.h"

#define WIDTH 1280
#define HEIGHT 720
#define APP_NAME "Mouse movement"


void mouse_callback(GLFWwindow *window, f64 xpos, f64 ypos);
void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset);
void key_callback(GLFWwindow *window, i32 key, i32 scanncode, i32 action, i32 mods);


int main() {
  glfwInit();

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, APP_NAME, null, null);

  if (window == null) {
    log(FATAL, "window is null");
    return 1;
  }

  i32 glew_res = glewInit();
  printf("glew_res: %d\n", glew_res);

  if (glew_res != 1 && glew_res != 4) {
    log(FATAL, "glewInit failed");
    return 1;
  }

  uint prog = programCreate("./vertex.glsl", "./fragment.glsl");
  uint texture = textureLoad("./crate.png");

  float vertices[] = {
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

  vec3 cubePositions[] = {
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

  uint VAO = vertexArrayCreate();
  vertexArrayBind(VAO);
  uint VBO = arrayBufferCreate(sizeof(vertices), vertices);
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(f32) * 5, (void *)0);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, sizeof(f32) * 5, (void *)(sizeof(f32) * 3));
  glEnableVertexAttribArray(1);

  programUse(prog);
  programSetI(prog, "texture1", 0);
  
  
  while(!glfwWindowShouldClose(window)) {
    glClear(GL_COLOR_BUFFER_BIT);


    glfwSwapBuffers(window);
    glfwPollEvents();
  }


  glfwDestroyWindow(window);
  glfwTerminate();

  return 0;
}


void mouse_callback(GLFWwindow *window, f64 xpos, f64 ypos) {
  
}
void scroll_callback(GLFWwindow *window, f64 xoffset, f64 yoffset) {
  
}
void key_callback(GLFWwindow *window, i32 key, i32 scanncode, i32 action, i32 mods) {
  
}
