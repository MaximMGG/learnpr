#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "../lib/util.hpp"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#define STB_IMAGE_IMPLEMENTATION
#include <stb/stb_image.h>

#define WIDTH 1920
#define HEIGHT 1024

void frameBufferSizeCallback(GLFWwindow *window, int width, int height);
void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, 1);
  }
}

u32 load_texture(const char *path);

int main() {
  glfwInit();
  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "test window", nullptr, nullptr);
  if (window == nullptr) {
    std::cerr << "glfwCreateWindow error\n";
    glfwTerminate();
    return 1;
  }

  glfwMakeContextCurrent(window);
  glfwSetFramebufferSizeCallback(window, frameBufferSizeCallback);
  glewInit();

  Shader shader("./vertex.glsl", "./fragment.glsl");
  if (shader.id == 0) {
    std::cerr << "Compile shader error\n";
    glfwDestroyWindow(window);
    glfwTerminate();
  }

  float vertices[] = {
    -0.5, 0.5, 0.0, 0.0, 1.0,
     0.5, 0.5, 0.0, 1.0, 1.0,
     0.5, -0.5, 0.0, 1.0, 0.0,
    -0.5, -0.5, 0.0, 0.0, 0.0
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

  GLCall(glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)0));
  GLCall(glEnableVertexAttribArray(0));
  GLCall(glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(f32), (void *)(sizeof(f32) * 3)));
  GLCall(glEnableVertexAttribArray(1));


  u32 tex = load_texture("container2.png");
  if (tex == 0) {
    std::cerr << "load_texture error";
    return 1;
  }

  shader.use();
  shader.setInt("texture1", 0);
  //GLCall(glBindBuffer(GL_ARRAY_BUFFER, VBO));

  while(!glfwWindowShouldClose(window)) {
    GLCall(glClear(GL_COLOR_BUFFER_BIT));
    processInput(window);

    shader.use();
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, tex);

    glm::mat4 projection(1.0f);
    glm::mat4 view(1.0f);
    glm::mat4 model(1.0f);
    projection = glm::perspective(glm::radians(45.0f), f32(WIDTH) / f32(HEIGHT), 0.1f, 100.0f);
    view = glm::translate(view, glm::vec3(0.0f, 0.0f, -3.0f));
    model = glm::rotate(model, glm::radians(-55.0f), glm::vec3(1.0f, 0.0f, 0.0f));


    shader.setMat4("projection", projection);
    shader.setMat4("view", view);
    shader.setMat4("model", model);

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

u32 load_texture(const char *path) {
  u32 tex;
  glGenTextures(1, &tex);
  glBindTexture(GL_TEXTURE_2D, tex);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  i32 width, height, nrChannels;
  u8 *data = stbi_load(path, &width, &height, &nrChannels, 0);
  if (data) {
    i32 format = nrChannels == 3 ? GL_RGB : nrChannels == 4 ? GL_RGBA : GL_RED;
    glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
    stbi_image_free(data);
  } else {
    glDeleteTextures(1, &tex);
    return 0;
  }

  return tex;
}
