#include "v_window.h"
#include <stdio.h>


VWindow *createWindow(i32 width, i32 height, str name) {
  VWindow *w = make(VWindow);
  w->width = width;
  w->height = height;
  w->name = strCopy(name);
  initWindow(w);
  return w;
}

void initWindow(VWindow *w) {
  if (!glfwInit()) {
    fprintf(stderr, "glfwInit error");
    return;
  }

  glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
  glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

  w->window = glfwCreateWindow(w->width, w->height, w->name, null, null);
  if (w->window == null) {
    fprintf(stderr, "glfwCreateWindow error");
    return;
  }
}

void destroyWindow(VWindow *w) {
  glfwDestroyWindow(w->window);
  glfwTerminate();
}

bool windowShouldClose(VWindow *w) {
  return glfwWindowShouldClose(w->window);
}
