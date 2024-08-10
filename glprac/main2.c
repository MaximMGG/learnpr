#include <GLFW/glfw3.h>


static void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods) {
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, GLFW_TRUE);
    }
}


int main() {

    glfwInit();
    GLFWwindow *window = glfwCreateWindow(720, 640, "Test window", NULL, NULL);

    glfwMakeContextCurrent(window);
    glfwSetKeyCallback(window, key_callback);

    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);
        glClearColor(0.1f, 0.1f, 0.1f, 1.0f);


        glfwPollEvents();

        glfwSwapBuffers(window);

    }

    glfwDestroyWindow(window);

    glfwTerminate();

    return 0;
}
