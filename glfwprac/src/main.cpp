#include "config.h"


int main() {

    GLFWwindow *window;

    if (!glfwInit()) {
        std::cerr << "GFLW can't start\n";
        return 1;
    }

    window = glfwCreateWindow(640, 480, "My window", NULL, NULL);
    glfwMakeContextCurrent(window);


    if(!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        glfwTerminate();
        std::cerr << "glad can't load GL\n";
    }


    glClearColor(0.25f, 0.5f, 0.75f, 1.0f);


    if(!window) {
        std::cerr << "Can't create window\n";
    } else {
        std::cout << "Window started\n";
    }


    while(!glfwWindowShouldClose(window)) {
        glfwPollEvents();

        glClear(GL_COLOR_BUFFER_BIT);

        glfwSwapBuffers(window);

    }



    glfwTerminate();

    std::cout << "Successfully ended\n";
    return 0;
}
