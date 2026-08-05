#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "rect.h"
#include "shader.h"
#include <cglm/cglm.h>

#define WIDTH 1280
#define HEIGHT 720

void frameBufferCallback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
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
  f32 vertices[] = {
    100, 200,
    200, 200,
    200, 100,
    100, 100 
  };

  u32 indeces[] = {
    0, 1, 2,
    0, 3, 2
  };

  u32 VAO, VBO, EBO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);
  glGenBuffers(1, &EBO);
  glBindVertexArray(VAO);
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indeces), indeces, GL_STATIC_DRAW);

  //Rect r = rectCreate(200, 200, 50, 100);

  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  mat4 ortho;
  glm_ortho(0, F32(WIDTH), F32(HEIGHT), 0, -1.0, 1.0, ortho);
  
  programUse(prog);
  programSetMat4(prog, "ortho", ortho);
  
  while(!glfwWindowShouldClose(window)) {
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    programUse(prog);
    //rectDraw(&r);
    
    glBindVertexArray(VAO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);

    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null);

    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glfwDestroyWindow(window);
  glfwTerminate();


  LOG(INFO, "End of OpenGL");
  logCleanup();
  return 0;
}
