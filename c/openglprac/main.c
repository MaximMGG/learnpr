#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <stdio.h>


int main() {

    GLFWwindow *win;
    if (!glfwInit()) {
        printf("Can't init \n" );
    }

    win = glfwCreateWindow(1280, 960, "Test window", NULL, NULL);

    if (!win) {
        glfwTerminate();
    }

    glfwMakeContextCurrent(win);

    if (glewInit() != GLEW_OK) {
        fprintf(stderr, "Glew not ok\n");
    } else {
        fprintf(stdout, "Glew OK\n");
    }

    printf("Current version of OPENGL - %s\n", glGetString(GL_VERSION));

    while(!glfwWindowShouldClose(win)) {
        glClear(GL_COLOR_BUFFER_BIT);

        glBegin(GL_TRIANGLES);
        
        glVertex2f(-0.5f, -0.5f);
        glVertex2f(0.0f, 0.5f);
        glVertex2f(0.5f, -0.5f);

        glEnd();

        glfwSwapBuffers(win);

        glfwPollEvents();
    }

    glfwTerminate();

    return 0;
}
