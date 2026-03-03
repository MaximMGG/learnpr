#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "../lib/util.hpp"
void frameBufferSizeCallback(GLFWwindow *window, int width, int height);
void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, 1);
  }
}

int main() {
  glfwInit();
  GLFWwindow *window = glfwCreateWindow(19280, 1024, "test window", nullptr, nullptr);
  if (window == nullptr) {
    std::cerr << "glfwCreateWindow error\n";
    glfwTerminate();
    return 1;
  }

  glfwMakeContextCurrent(window);
  //glfwSetFramebufferSizeCallback(window, frameBufferSizeCallback);
  glewInit();

  Shader shader("./vertex.glsl", "./fragment.glsl");
  if (shader.id == 0) {
    std::cerr << "Compile shader error\n";
    glfwDestroyWindow(window);
    glfwTerminate();
  }

  float vertices[] = {
    -0.5, 0.5, 0.0,
     0.5, 0.5, 0.0,
     0.5, -0.5, 0.0,
    -0.5, -0.5, 0.0,
  };

  unsigned int indecies[] = {
    0, 1, 2, 2, 3, 0
  };

  unsigned int VAO, VBO, EBO;

  GLCall(glGenVertexArrays(1, &VAO));
  GLCall(glBindVertexArray(VAO));

  GLCall(glGenBuffers(1, &VBO));
  GLCall(glGenBuffers(1, &EBO));
  GLCall(glBindBuffer(GL_ARRAY_BUFFER, VBO));
  GLCall(glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW));

  GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO));
  GLCall(glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW));

  GLCall(glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(f32), (void *)0));
  GLCall(glEnableVertexAttribArray(0));



  shader.use();
  GLCall(glBindBuffer(GL_ARRAY_BUFFER, VBO));

  while(!glfwWindowShouldClose(window)) {
    GLCall(glClear(GL_COLOR_BUFFER_BIT));
    processInput(window);

    shader.use();

    GLCall(glBindVertexArray(VAO));
    GLCall(glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0));

    glfwSwapBuffers(window);
    glfwPollEvents();

  }

  glDeleteVertexArrays(1, &VAO);
  glDeleteBuffers(1, &VBO);
  glDeleteBuffers(1, &EBO);

  return 0;
}

void frameBufferSizeCallback(GLFWwindow *window, int width, int height) {
  glViewport(0, 0, width, height);
}
