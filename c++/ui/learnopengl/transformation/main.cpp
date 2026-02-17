#include <iostream>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

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



  return 0;
}
