#include "window.hpp"
#include <GLFW/glfw3.h>
#include <iostream>
#include "drawing.hpp"



int main() {
    int width = 720;
    int heigth = 720;
    WindowMenager window(width, heigth, "My window");
    window.setupCallbacks();

    while(!glfwWindowShouldClose(window.window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        double xpos, ypos;
        glfwGetCursorPos(window.window, &xpos, &ypos);

        float x = (float)xpos / width * 2.0f - 1.0f;
        float y = -(float)ypos / heigth * 2.0f - 1.0f;
        const float radius = 0.005f;

        std::vector<float> currentCircle = drawCircle(x, y, radius, 32);


        glfwSwapBuffers(window.window);
        glfwPollEvents();
    }

    return 0;
}
