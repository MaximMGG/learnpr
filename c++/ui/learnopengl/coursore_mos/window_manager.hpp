#ifndef WINDOW_MANAGER_HPP
#define WINDOW_MANAGER_HPP
#include <GLFW/glfw3.h>
#include <iostream>
#include <unistd.h>
#include <stdlib.h>

class WindowManager {
public:
  GLFWwindow *window;
  bool firstMouse;

  WindowManager(int width, int height, const char *name);
  ~WindowManager();

  void process();
  void setCallbacks(void (*mouse_callback)(GLFWwindow*, double, double), void (*scroll_callback)(GLFWwindow*, double, double));
private:
};

#endif //WINDOW_MANAGER_HPP
