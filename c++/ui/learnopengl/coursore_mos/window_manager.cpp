#include "window_manager.hpp"


void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods);
void mousePos_callback(GLFWwindow *window, double xpos, double ypos);
void scroll_callback(GLFWwindow *window, double xoffset, double yoffset);
WindowManager::WindowManager(int width, int height, const char *name) {
        glfwInit();
        window = glfwCreateWindow(width, height, name, NULL, NULL);
        if (window == NULL) {
            std::cerr << "glfwCreateWindow failed\n";
            exit(1);
        }
        glfwMakeContextCurrent(window);
        glfwSetKeyCallback(window, key_callback);
        glfwSetCursorPosCallback(window, mousePos_callback);
        glfwSetScrollCallback(window, scroll_callback);
}

WindowManager::~WindowManager() {
    glfwDestroyWindow(window);
    glfwTerminate();
}

