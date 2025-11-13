#ifndef WINDOW_MANAGER_HPP
#define WINDOW_MANAGER_HPP
#include <GLFW/glfw3.h>
#include <iostream>
#include <unistd.h>
#include <stdlib.h>

void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods);
void mousePos_callback(GLFWwindow *window, double xpos, double ypos);
void scroll_callback(GLFWwindow *window, double xoffset, double yoffset);

class WindowManager {
public:
    GLFWwindow *window;

    WindowManager(int width, int height, const char *name);
    ~WindowManager();
    void process();
};

#endif //WINDOW_MANAGER_HPP
