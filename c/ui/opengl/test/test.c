#include <GL/glew.h>
#include <GLFW/glfw3.h>



int main() {
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(1280, 720, "ij", NULL, NULL);

    glfwMakeContextCurrent(window);

    if (glewInit() != 4) {
        return 1;
    }

    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);


        glfwSwapBuffers(window);
        glfwPollEvents();
    }


    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}
