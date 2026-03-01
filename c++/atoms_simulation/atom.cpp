#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <vector>
#include <iostream>
#include <cmath>
#include <cstdlib>
#include <ctime>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

struct Engine {

  GLFWwindow *window;
  int WIDTH = 800, HEIGHT = 600;

  Engine() {
    if (!glfwInit()) {
      std::cerr << "Failed to init glfw\n";
      exit(1);
    }

    window = glfwCreateWindow(WIDTH, HEIGHT, "2D atom sim", nullptr, nullptr);

    if (!window) {
      std::cerr << "failed to create window\n";
      glfwTerminate();
      exit(1);
    }

    glfwMakeContextCurrent(window);
  }
};

Engine engine;

int main() {


  while(!glfwWindowShouldClose(engine.window)) {

    glfwSwapBuffers(engine.window);
    glfwPollEvents();
  }

  return 0;
}
