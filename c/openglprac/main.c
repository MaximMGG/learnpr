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

    float position[6] = {
        -0.5f,  -0.5f,
         0.0f,   0.5f,
         0.5f,  -0.5f
    };
    unsigned int buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(position), position, GL_STATIC_DRAW);

    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 2, 0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);

    while(!glfwWindowShouldClose(win)) {
        glClear(GL_COLOR_BUFFER_BIT);

        glDrawArrays(GL_TRIANGLES, 0, 3);

        glfwSwapBuffers(win);

        glfwPollEvents();
    }

    glfwTerminate();

    return 0;
}
