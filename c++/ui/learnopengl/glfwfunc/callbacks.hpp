#ifndef CALLBACKS_HPP
#define CALLBACKS_HPP

#include <GLFW/glfw3.h>
#include <iostream>

void mouseButtonCallback(GLFWwindow *window, int button, int action, int mods);
void cursorPositionCallback(GLFWwindow *window, double xpos, double ypos);
void keyCallback(GLFWwindow *window, int key, int scancode, int action, int mods);

#endif
