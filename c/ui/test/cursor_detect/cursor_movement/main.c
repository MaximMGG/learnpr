#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "rect.h"
#include "circle.h"
#include "shader.h"
#include <cglm/cglm.h>

#define WIDTH 1280
#define HEIGHT 720

f64 x = 0.0;
f64 y = 0.0;
bool new_rect = false;
bool reset = false;
bool new_circle = false;

void frameBufferCallback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}


void process_input(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }

  if (glfwGetKey(window, GLFW_KEY_R) == GLFW_PRESS) {
    reset = true;
  }

  if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS) {
    glfwGetCursorPos(window, &x, &y);
    new_rect = true;
  }
  if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_PRESS) {
    glfwGetCursorPos(window, &x, &y);
    new_circle = true;
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

  Program circle_prog = programLoad("circle_vertex.glsl", "circle_fragment.glsl");
  if (circle_prog == 0) {
    LOG(ERROR, "cirlce programLoad error");
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
  Circle *dc = daCreate(Circle);

  mat4 ortho;
  glm_ortho(0, F32(WIDTH), F32(HEIGHT), 0, -1.0, 1.0, ortho);
  
  programUse(prog);
  programSetMat4(prog, "ortho", ortho);

  programUse(circle_prog);
  programSetMat4(circle_prog, "ortho", ortho);
  // programSetFloat(circle_prog, "width", F32(WIDTH));
  // programSetFloat(circle_prog, "height", F32(HEIGHT));

  while(!glfwWindowShouldClose(window)) {
    process_input(window);
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    if (new_rect) {
      if (x > 0.0 && y > 0.0) {
        daAppend(dr, rectCreate(I32(x), I32(y), 20, 20));
        new_rect = false;
      }
    }
    if (new_circle) {
      if (x > 0.0 && y > 0.0) {
        daAppend(dc, circleCreate(F32(x), F32(y), F32(10), circle_prog));
        new_circle = false;
      }
    }

    if (reset) {
      for(i32 i = 0; i < DA_LEN(dr); i++) {
        daRemoveUnordered(dr, i);
      }
      for(i32 i = 0; i < DA_LEN(dc); i++) {
        daRemoveUnordered(dc, i);
      }
      reset = false;
    }

    programUse(prog);
    for(i32 i = 0; i < DA_LEN(dr); i++) {
      rectDraw(&dr[i]);
    }
    programUse(circle_prog);
    for(i32 i = 0; i < DA_LEN(dc); i++) {
      circleDraw(&dc[i]);
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



