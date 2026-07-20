#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <mh/core/types.hpp>
#include <stdio.h>
#include "shader.hpp"
#include <glm/glm.hpp>


#define WIDTH 1280
#define HEIGHT 960


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

  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);

  Shader prog{"./vertex.glsl", "./fragment.glsl"};
  
  if (!prog.success) {
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
  }

  f32 vertices[] = {
    -0.5f,  0.5f,
     0.5f,  0.5f,
     0.5f, -0.5f,

    -0.5f,  0.5f,
    -0.5f, -0.5f,
     0.5f, -0.5f,
  };

  u32 VBO, VAO;
  glGenVertexArrays(1, &VAO);
  glGenBuffers(1, &VBO);

  glBindVertexArray(VAO);

  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  glBindBuffer(GL_ARRAY_BUFFER, 0);


  glm::vec2 resolution{f32(WIDTH), f32(HEIGHT)};
  prog.use();
  prog.setVec2("aResolution", resolution);

  while(!glfwWindowShouldClose(window)) {
    glClearColor(0.2, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);

    prog.use();
    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, 6);
    

    glfwSwapBuffers(window);
    glfwPollEvents();
  }


  glfwDestroyWindow(window);
  glfwTerminate();
  
  return 0;
}

