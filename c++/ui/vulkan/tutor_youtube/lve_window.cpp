#include "lve_window.hpp"
#include <GLFW/glfw3.h>
#include <cstdio>
#include <cstdlib>


namespace lve {
  LveWindow::LveWindow(int w, int h, std::string name) : width(w), height(h), name(name){
    initWindow();
  }

  LveWindow::~LveWindow() {
    glfwDestroyWindow(window);
    glfwTerminate();
  }
  
  void LveWindow::initWindow() {
    if (!glfwInit()) {
      fprintf(stderr, "glfwInit error");
    }
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    window = glfwCreateWindow(width, height, name.c_str(), NULL, NULL);
  }

  bool LveWindow::shouldClose() {
    return glfwWindowShouldClose(window);
  }
  void LveWindow::createWindowSurface(VkInstance instance, VkSurfaceKHR *surface) {
    if (glfwCreateWindowSurface(instance, window, NULL, surface) != VK_SUCCESS) {
      fprintf(stderr, "Failed to create Vulkan surface\n");
    }
  }
}
