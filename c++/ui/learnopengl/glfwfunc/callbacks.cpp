#include "callbacks.hpp"

void mouseButtonCallback(GLFWwindow *window, int button, int action, int mods) {
    if (button == GLFW_MOUSE_BUTTON_LEFT) {
        std::cout << "left mouse is pressed\n";
    } else if (button == GLFW_MOUSE_BUTTON_RIGHT) {
        std::cout << "right mouse is pressed\n";
    }
}

void cursorPositionCallback(GLFWwindow *window, double xpos, double ypos) {
    std::cout << "Cursor position: ("  << xpos << ", " << ypos << '\n';
}

void keyCallback(GLFWwindow *window, int key, int scancode, int action, int mods) {
    if (key == GLFW_KEY_ESCAPE) {
        glfwSetWindowShouldClose(window, true);
    }
    std::cout << "Key pressed: " << key << '\n';
}
