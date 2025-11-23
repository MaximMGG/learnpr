#include "window_manager.hpp"


void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods) {
  
}

void mousePos_callback(GLFWwindow *window, double xposIn, double yposIn) {
  float xpos = static_cast<float>(xposIn);
  float ypos = static_cast<float>(yposIn);
   
}
void scroll_callback(GLFWwindow *window, double xoffset, double yoffset) {
  
}

WindowManager::WindowManager(int width, int height, const char *name) {
  glfwInit();
  window = glfwCreateWindow(width, height, name, NULL, NULL);
  if (window == NULL) {
    std::cerr << "glfwCreateWindow failed\n";
    exit(1);
  }

  glfwSetKeyCallback(window, key_callback);
  glfwSetCursorPosCallback(window, mousePos_callback);
  glfwSetScrollCallback(window, scroll_callback);

  glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
  glfwMakeContextCurrent(window);
}

WindowManager::~WindowManager() {
  glfwDestroyWindow(window);
  glfwTerminate();
}
__inline void WindowManager::process() {
  glfwSwapBuffers(window);
  glfwPollEvents();
}


