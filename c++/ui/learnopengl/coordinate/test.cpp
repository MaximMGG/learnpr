#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>


int main() {

    glfwInit();

    GLFWwindow *window = glfwCreateWindow(1280, 720, "TEST", NULL, NULL);

    glfwMakeContextCurrent(window);
    if (glewInit() != 0) {
        std::cerr << "glfwInit failed\n";
        return 1;
    }


    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);


        glfwSwapBuffers(window);
        glfwPollEvents();

    }

    glfwTerminate();

    return 0;
}
