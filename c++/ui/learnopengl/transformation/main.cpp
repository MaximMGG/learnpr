#include <iostream>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

#include "shader.hpp"
#include "vertexArray.hpp"
#include "vertexAttrib.hpp"
#include "vertexBuffer.hpp"
#include "vertexElement.hpp"
#include "texture.hpp"

#define WIDTH 720
#define HEIGHT 480

int main() {
  std::cout << "Init glfw\n";

  glfwInit();

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "test", NULL, NULL);
  if (window == NULL) {
    std::cerr << "glfwCreateWindow error\n";
    return 1;
  }

  glfwMakeContextCurrent(window);
  int glew_init = glewInit();
  if (glew_init != 1 && glew_init != 4) {
    std::cerr << "glewInit error\n";
    glfwTerminate();
    return 1;
  }

  Shader program("./vertex.glsl", "./fragment.glsl");

  float vertices[] = {
    // positions          // texture coords
    0.5f,  0.5f, 0.0f,   1.0f, 1.0f, // top right
    0.5f, -0.5f, 0.0f,   1.0f, 0.0f, // bottom right
    -0.5f, -0.5f, 0.0f,   0.0f, 0.0f, // bottom left
    -0.5f,  0.5f, 0.0f,   0.0f, 1.0f  // top left 
  };
  unsigned int indices[] = {
    0, 1, 3, // first triangle
    1, 2, 3  // second triangle
  };

  VertexAttrib VAO;
  VertexBuffer VBO(vertices, sizeof(vertices));
  VertexElement EBO(indices, sizeof(indices));

  VAO.addf32(3);
  VAO.addf32(2);
  VAO.process();

  Texture tex("./crate.png");

  program.use();
  program.setInt("texture1", 0);

  while(!glfwWindowShouldClose(window)) {

  }

  return 0;
}
