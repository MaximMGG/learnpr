#ifndef MY_WINDOW_HPP
#define MY_WINDOW_HPP
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <iostream>
#include "callbacks.hpp"

class WindowMenager {
public:
    GLFWwindow *window;

    WindowMenager(int width, int height, const char *name) {
        glfwInit();
        window = glfwCreateWindow(width, height, name, NULL, NULL);
        glfwMakeContextCurrent(window);

        if (glewInit() != 0) {
            std::cerr << "glewinit failed\n";
        }
    }
    ~WindowMenager() {
        glfwDestroyWindow(window);
        glfwTerminate();
    }

    void setupCallbacks() {
        glfwSetMouseButtonCallback(window, mouseButtonCallback);
        glfwSetCursorPosCallback(window, cursorPositionCallback);
        glfwSetKeyCallback(window, keyCallback);
    }
};

#endif
