#ifndef WINDOW_MANAGER_HPP
#define WINDOW_MANAGER_HPP
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include <unistd.h>
#include <stdlib.h>
#include "types.hpp"

class WindowManager {
  public:
    GLFWwindow *window;
    void setCallbacks(void (*mouse_callback)(GLFWwindow*, double, double), void (*scroll_callback)(GLFWwindow*, double, double)) {
      glfwSetCursorPosCallback(window, mouse_callback);
      glfwSetScrollCallback(window, scroll_callback);
    }

    WindowManager(int width, int height, const char *name) {
      glfwInit();
      window = glfwCreateWindow(width, height, name, NULL, NULL);
      if (window == NULL) {
        std::cerr << "glfwCreateWindow failed\n";
        exit(1);
      }

      glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
      glfwMakeContextCurrent(window);

      i32 res = glewInit();
      if (res != 0 && res != 4) {
        std::cerr << "glewInit failed\n";
        exit(1);
      }

      glEnable(GL_DEPTH_TEST);

    }

    ~WindowManager() {
      glfwDestroyWindow(window);
      glfwTerminate();
    }

    void process() {
      glfwSwapBuffers(window);
      glfwPollEvents();
    }
};

#endif //WINDOW_MANAGER_HPP
