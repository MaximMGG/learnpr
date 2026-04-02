#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "../lib/util.hpp"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

#define WIDTH 800
#define HEIGHT 800

int main() {

  WindowManager window(WIDTH, HEIGHT, "Piramid");


  f32 vertices[] = {
    -0.5f, 0.0f,  0.5f,     0.83f, 0.70f, 0.44f,	0.0f, 0.0f,
    -0.5f, 0.0f, -0.5f,     0.83f, 0.70f, 0.44f,	5.0f, 0.0f,
    0.5f, 0.0f, -0.5f,     0.83f, 0.70f, 0.44f,	0.0f, 0.0f,
    0.5f, 0.0f,  0.5f,     0.83f, 0.70f, 0.44f,	5.0f, 0.0f,
    0.0f, 0.8f,  0.0f,     0.92f, 0.86f, 0.76f,	2.5f, 5.0f
  };

  u32 indices[] = {
    0, 1, 2,
    0, 2, 3,
    0, 1, 4,
    1, 2, 4,
    2, 3, 4,
    3, 0, 4
  };

  Shader shader("./vertex.glsl", "./fragment.glsl");
  if (shader.id == 0) {
    std::cout << "Shader compile error\n";
    return 1;
  }

  glViewport(0, 0, WIDTH, HEIGHT);

  VertexArray VAO;
  BufferArray VBO(sizeof(vertices), vertices);
  
  u32 EBO;
  glGenBuffers(1, &EBO);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);

  VAO.addf32(3);
  VAO.addf32(3);
  VAO.addf32(2);
  VAO.process();

  Texture tex("./brick.png");

  shader.use();
  shader.setInt("tex0", 0);


  f32 rotation = 0.0f;
  f64 prevTime = glfwGetTime();

  while(!glfwWindowShouldClose(window.window)) {

    glClearColor(0.07f, 0.13f, 0.17f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    shader.use();
    glActiveTexture(GL_TEXTURE0);
    tex.bind();

    f64 currentTime = glfwGetTime();
    if (currentTime - prevTime >= f64(1) / 60.0) {
      rotation += 0.5f;
      prevTime = currentTime;
    }

    glm::mat4 model = glm::mat4(1.0f);
    glm::mat4 view = glm::mat4(1.0f);
    glm::mat4 projection = glm::mat4(1.0f);

    model = glm::rotate(model, glm::radians(rotation), glm::vec3(0.0f, 1.0f, 0.0f));
    view = glm::translate(view, glm::vec3(0.0f, -0.5f, -2.0f));
    projection = glm::perspective(glm::radians(45.0f), f32(WIDTH) / HEIGHT, 0.1f, 100.0f);

    shader.setMat4("model", model);
    shader.setMat4("view", view);
    shader.setMat4("projection", projection);

    VAO.bind();
    glDrawElements(GL_TRIANGLES, sizeof(indices) / sizeof(u32), GL_UNSIGNED_INT, 0);

    glfwSwapBuffers(window.window);
    glfwPollEvents();
  }

  return 0;
}
