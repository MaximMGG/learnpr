#ifndef V_WINDOW_H
#define V_WINDOW_H 
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <cstdext/core.h>
#include <stdlib.h>


typedef struct {
  i32 width, height;
  str name;
  GLFWwindow *window;
} VWindow;

VWindow *createWindow(i32 width, i32 height, str name);
void initWindow(VWindow *w);
void destroyWindow(VWindow *w);
bool windowShouldClose(VWindow *w);


#endif //V_WINDOW_H
