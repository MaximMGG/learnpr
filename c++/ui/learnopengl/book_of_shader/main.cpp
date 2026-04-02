#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include "shader.hpp"
#include <glm/glm.hpp>


#define WIDTH 1280
#define HEIGHT 720

int main() {
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Shader", NULL, NULL);

    if (window == NULL) {
        std::cerr << "window is null\n";
    }


    glfwMakeContextCurrent(window);

    if (glewInit() != 0) {
        std::cerr << "glewInit failed\n";
    }

    Shader prog("./vertex.glsl", "./fragment.glsl");

    float vertices[] = {
        0.5,  0.5,
        0.5, -0.5,
       -0.5, -0.5,
       -0.5,  0.5
    };

    unsigned int indeces[] = {
        0, 1, 2, 2, 0, 3
    };

    unsigned int VAO, VBO, EBO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indeces), indeces, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 2, (void *)0);
    glEnableVertexAttribArray(0);

    // glBindBuffer(GL_ARRAY_BUFFER, 0);
    // glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    // glBindVertexArray(0);


    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);
        prog.use();

        glm::vec2 resolution(1.3, 0.4);
        //prog.setFloat("u_time", (float)glfwGetTime());
        prog.setVec2("u_resolution", resolution);
        glBindVertexArray(VAO);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);


        glfwSwapBuffers(window);
        glfwPollEvents();
    }


    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}

