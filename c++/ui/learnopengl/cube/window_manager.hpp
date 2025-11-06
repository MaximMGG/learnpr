#ifndef WINDOW_MANAGER_HPP
#define WINDOW_MANAGER_HPP
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>

class WindowManager {
public:
    GLFWwindow *window;
    WindowManager(int width, int height, const char *title) {
        glfwInit();
        window = glfwCreateWindow(width, height, title, NULL, NULL);
        if (window == NULL) {
            printf("Window is NULL\n");
            glfwTerminate();
            exit(1);
        }
        glfwMakeContextCurrent(window);
    }

    ~WindowManager() {
        glfwDestroyWindow(window);
        glfwTerminate();
    }

    void work() {
        glfwSwapBuffers(window);
        glfwPollEvents();
    }


};


#endif
