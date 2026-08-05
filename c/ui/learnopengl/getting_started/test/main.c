#include <cstdext/core.h>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h> 
#include "shader.h"


#define WIDTH 1280
#define HEIGHT 720

void processInput(GLFWwindow *window);



i32 main() {

  logSetOpt(LOG_OPTION_DEF, LOG_TYPE_FILE, "gl_log.log");
  glfwInit();


  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Test window", null, null);
  if (window == null) {
    LOG(ERROR, "glfwCreateWindwo error");
    glfwTerminate();
    return 1;
  }

  glfwMakeContextCurrent(window);

  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
  

  
  u32 prog = programCreate("vertex.glsl", "fragment.glsl");

  f32 vertices[] = {
    -0.5f,  0.5f, 0.0f,
     0.5f,  0.5f, 0.0f,
     0.5f, -0.5f, 0.0f,
    
     0.5f, -0.5f, 0.0f,
    -0.5f, -0.5f, 0.0f,
    -0.5f,  0.5f, 0.0f,
  };

  u32 VBO, VAO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);
  glBindVertexArray(VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  programUse(prog);
  
  while(!glfwWindowShouldClose(window)) {
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, 6);
    
    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  glDeleteProgram(prog);
  glDeleteVertexArrays(1, &VAO);
  glDeleteBuffers(1, &VBO);
  glfwDestroyWindow(window);
  glfwTerminate();
  
  return 0;
  
}

void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
}


