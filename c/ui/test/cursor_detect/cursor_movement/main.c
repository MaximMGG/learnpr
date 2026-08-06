#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "rect.h"
#include "shader.h"
#include <cglm/cglm.h>

#define WIDTH 1280
#define HEIGHT 720

f64 x = 0.0;
f64 y = 0.0;
bool new_rect = false;

void frameBufferCallback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}


void process_input(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS) {
    glfwGetCursorPos(window, &x, &y);
    new_rect = true;
  }
}


i32 main() {
  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");

  if (!glfwInit()) {
    LOG(ERROR, "glfwInit error");
    return 1;
  }

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Cursor experiments", null, null);
  if (!window) {
    LOG(ERROR, "glfwCreateWindow error");
    glfwTerminate();
    return 1;
  }

  LOG(INFO, "init glfw and Craete Window");

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  glfwMakeContextCurrent(window);
  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  LOG(INFO, "Init OpenGL");

  Program prog = programLoad("vertex.glsl", "fragment.glsl");
  if (prog == 0) {
    LOG(ERROR, "programLoad error");
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  // f32 vertices[] = {
  //   -0.5, 0.5,
  //   0.5, 0.5,
  //   0.5, -0.5,
  //   -0.5, -0.5
  // };
  // f32 vertices[] = {
  //   100, 200,
  //   200, 200,
  //   200, 100,
  //   100, 100 
  // };

  // u32 indeces[] = {
  //   0, 1, 2,
  //   0, 3, 2
  // };


  Rect *dr = daCreate(Rect);


  mat4 ortho;
  glm_ortho(0, F32(WIDTH), F32(HEIGHT), 0, -1.0, 1.0, ortho);
  
  programUse(prog);
  programSetMat4(prog, "ortho", ortho);
  
  while(!glfwWindowShouldClose(window)) {
    process_input(window);
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    programUse(prog);

    if (new_rect) {
      if (x > 0.0 && y > 0.0) {
        daAppend(dr, rectCreate(I32(x), I32(y), 50, 50));
        new_rect = false;
      }
    }

    for(i32 i = 0; i < DA_LEN(dr); i++) {
      rectDraw(&dr[i]);
    }
    
    //glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);

    //glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  for(i32 i = 0; i < DA_LEN(dr); i++) {
    rectDestroy(dr[i]);
  }


  glfwDestroyWindow(window);
  glfwTerminate();

  daDestroy(dr);

  LOG(INFO, "End of OpenGL");
  logCleanup();
  return 0;
}



