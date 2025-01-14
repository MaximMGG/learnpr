#include "../headers/config.h"
#include <GLFW/glfw3.h>

#define WIDTH 640
#define HEIGHT 480



int main() {

    GLFWwindow *window;

    if (!glfwInit()) {
        std::cerr << "glfw can't be init\n";
        return 1;
    }

    window = glfwCreateWindow(WIDTH, HEIGHT, "My super window", NULL, NULL);
    glfwMakeContextCurrent(window);


    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cerr << "GL can't start\n";
        glfwTerminate();
        return 1;
    }

    std::cout << "Window init\n";



    glClearColor(0.25f, 0.5f, 0.75f, 1.0f);

    while(!glfwWindowShouldClose(window)) {
        glfwPollEvents();

        glClear(GL_COLOR_BUFFER_BIT);

        glfwSwapBuffers(window);

    }

    glfwTerminate();
    std::cout << "Terminated\n";

    return 0;
}
