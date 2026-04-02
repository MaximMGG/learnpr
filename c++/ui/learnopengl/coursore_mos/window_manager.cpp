#include "window_manager.hpp"

void WindowManager::setCallbacks(void (*mouse_callback)(GLFWwindow*, double, double), void (*scroll_callback)(GLFWwindow*, double, double)) {
  glfwSetCursorPosCallback(window, mouse_callback);
  glfwSetScrollCallback(window, scroll_callback);
}

WindowManager::WindowManager(int width, int height, const char *name) {
  glfwInit();
  firstMouse = true;
  window = glfwCreateWindow(width, height, name, NULL, NULL);
  if (window == NULL) {
    std::cerr << "glfwCreateWindow failed\n";
    exit(1);
  }

  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
  glfwMakeContextCurrent(window);
}

WindowManager::~WindowManager() {
  glfwDestroyWindow(window);
  glfwTerminate();
}

void WindowManager::process() {
  glfwSwapBuffers(window);
  glfwPollEvents();
}


