#include <GLFW/glfw3.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


int main() {
    if (!glfwInit()) {
        exit(EXIT_FAILURE);
    }
    GLFWwindow *win = glfwCreateWindow(720, 720, "Circle", NULL, NULL);
    if (!win) {
        glfwTerminate();
        fprintf(stderr, "Create window fail\n");
    }
    glfwMakeContextCurrent(win);
    glfwSwapInterval(1);

    const float DEG2RAD = 3.14159 / 180;
    float radius = 0.25;
    float r = 0.0;
    float g = 0.3;
    float b = 0.6;

    float x = 0;
    float y = 0;

    while(!glfwWindowShouldClose(win)) {
        float ratio;
        int width, height;
        glfwGetFramebufferSize(win, &width, &height);

        ratio = width / (float) height;
        glViewport(0, 0, width, height);
        glClear(GL_COLOR_BUFFER_BIT);

        //Movement
        
        if (glfwGetKey(win, GLFW_KEY_RIGHT)) {
            x += 0.01;
        } else if (glfwGetKey(win, GLFW_KEY_LEFT)) {
            x -= 0.01;
        } else if (glfwGetKey(win, GLFW_KEY_UP)) {
            y += 0.01;
        } else if (glfwGetKey(win, GLFW_KEY_DOWN)) {
            y -= 0.01;
        }


        //Color
        r = fmod(r + 0.01, 1);
        g = fmod(g + 0.02, 1);
        b = fmod(b + 0.03, 1);
       
        //Drawing
        glColor3f(r, g, b);
        glBegin(GL_POLYGON);
        for(int i = 0; i < 360; i++) {
            float degInRad = i * DEG2RAD;
            glVertex2f(cos(degInRad) * radius + x, sin(degInRad) * radius + y);
        }
        glEnd();

        //swap buffer and check for events
        glfwSwapBuffers(win);
        glfwPollEvents();
    }

    glfwDestroyWindow(win);
    glfwTerminate();

    return 0;
}
