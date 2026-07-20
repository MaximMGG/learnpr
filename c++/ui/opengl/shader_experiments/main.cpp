#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <mh/core/types.hpp>
#include <stdio.h>
#include <glm/glm.hpp>
#include "shader.hpp"


#define WIDTH 1280
#define HEIGHT 960


void process_input(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
}

void framebuffer_callback(GLFWwindow *window, i32 width, i32 height) {
  glViewport(0, 0, width, height);
}

i32 main() {

  if (!glfwInit()) {
    fprintf(stderr, "glfwInit error\n");
    return 1;
  }

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Circle", nullptr, nullptr);
  if (window == nullptr) {
    fprintf(stderr, "glfwCreateWindow failed\n");
    glfwTerminate();
    return 1;
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  glfwMakeContextCurrent(window);
  glfwSetFramebufferSizeCallback(window, framebuffer_callback);

  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  {


    f32 vertices[] = {
      -1.0, -1.0,
      -1.0,  1.0,
      1.0,   1.0,
      1.0,  -1.0,
    };

    u32 indecies[] = {
      0, 1, 2,
      0, 3, 2
    };

    u32 VBO, EBO,VAO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(f32), (void *)0);
    glEnableVertexAttribArray(0);

    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

    while (!glfwWindowShouldClose(window)) {
      Shader prog{"./vertex.glsl", "./fragment.glsl"};

      
      
      glClearColor(0.2, 0.3, 0.3, 1.0);
      glClear(GL_COLOR_BUFFER_BIT);
      process_input(window);

      glm::vec2 resolution{f32(WIDTH), f32(HEIGHT)};
      prog.use();
      prog.setVec2("aResolution", resolution);

      glBindVertexArray(VAO);
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
      glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, nullptr);

      glfwSwapBuffers(window);
      glfwPollEvents();
    }
    glDeleteBuffers(1, &VBO);
    glDeleteVertexArrays(1, &VAO);
  }

  glfwDestroyWindow(window);
  glfwTerminate();
  
  return 0;
}





