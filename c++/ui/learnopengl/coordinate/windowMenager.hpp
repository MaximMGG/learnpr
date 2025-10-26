#ifndef WINDOW_MENAGER_HPP
#define WINDOW_MENAGER_HPP
#include <iostream>
#include "render.hpp"


class WindowMenager {
public:
    GLFWwindow *window;

    WindowMenager(int width, int height, const char *name) {
        glfwInit();

        window = glfwCreateWindow(width, height, name, NULL, NULL);
        if (window == NULL) {
            std::cerr << "glfwCreateWindow failed\n";
            return;
        }

        glfwMakeContextCurrent(window);

        if (glewInit() != 0) {
            std::cerr << "glewInit failed\n";
            return;
        }
    }

    ~WindowMenager(){
        if (window != NULL) {
            glfwDestroyWindow(window);
        }
        glfwTerminate();
    }

    void enableDepth() {
        glEnable(GL_DEPTH_TEST);
    }
};


#endif
