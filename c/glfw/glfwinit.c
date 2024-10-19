#include <glad/gl.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <stdlib.h>


int main() {

    if (!glfwInit()) {
        fprintf(stderr, "Cant init glfw\n");
        return EXIT_FAILURE;
    }

    GLFWwindow *win = glfwCreateWindow(1280, 720, "GFLW simple winfow", NULL, NULL);

    if (!win) {
        glfwTerminate();
        fprintf(stderr, "Cant create window gflw\n");
        return EXIT_FAILURE;
    }

    glfwMakeContextCurrent(win);

    while(!glfwWindowShouldClose(win)) {
        

        glfwSwapBuffers(win);

        glfwPollEvents();
    }

    glfwDestroyWindow(win);
    glfwTerminate();

    return 0;
}
