#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>


#define WIDTH 1280
#define HEIGHT 720


int main() {
    glfwInit();

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "TEST", NULL, NULL);
    if (window == NULL) {
        std::cerr << "window id NULL\n";
    }

    glfwMakeContextCurrent(window);

    int res = glewInit();

    if (res != 0 && res != 4) {
        std::cerr << "glewInit failed\n";
        std::cerr << "Error is: " << res << '\n';
        const unsigned char *err = glewGetErrorString(res);
        std::cerr << err << '\n';
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
