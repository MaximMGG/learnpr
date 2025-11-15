#include <stdio.h>
#include <stdlib.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>


#define WIDTH 1280
#define HEIGHT 720
#define WIN_NAME "Chess application"

void key_callback(GLFWwindow *window, int key, int scancode, int action, int mode) {
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, true);
    }
}


int main() {

    glfwInit();
    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, WIN_NAME, null, null);
    if (window == null) {
        log(FATAL, "glfwCreateWindow failed");
        glfwTerminate();
        return 1;
    }

    glfwSetKeyCallback(window, key_callback);

    glfwMakeContextCurrent(window);

    while(!glfwWindowShouldClose(window)) {

        glfwSwapBuffers(window);
        glfwPollEvents();
    }


    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
