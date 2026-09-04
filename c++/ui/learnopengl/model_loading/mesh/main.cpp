#include <glad/glad.h>
#include "model.hpp"
#include <GLFW/glfw3.h>

#define WIDTH 1280
#define HEIGHT 720


void processInput(GLFWwindow *window) {
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
    glfwSetWindowShouldClose(window, true);
  }
}


i32 main() {

  glfwInit();

  GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Model", NULL, NULL);

  if (window == NULL) {
    std::cerr << "glfwCreateWindow error\n";
    glfwTerminate();
    return 1;
  }

  glfwWindowHint(GLFW_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
  glEnable(GL_DEPTH_TEST);


  auto model = Model("backpack.obj");


  while(!glfwWindowShouldClose(window)) {
    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    model.draw();

    glfwSwapBuffers(window);
    glfwPollEvents();
  }


  glfwTerminate();
  return 0;
}
