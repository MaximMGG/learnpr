#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <unistd.h>
#include <GL/gl.h>
#include "vertex_array.hpp"
#include "vertex_buffer.hpp"
#include "vertex_buffer_layout.hpp"
#include "index_buffer.hpp"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include "shader.hpp"


#define WIDTH 1280
#define HEIGHT 720

void checkPoll(GLFWwindow *window) {
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, true);
    }
}


int main() {
    std::cout << "Start opengl app\n";
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "OPENGL WINDOW", NULL, NULL);
    if (window == NULL) {
        std::cerr << "glfwCreateWindow error\n";
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(window);

    if (glewInit() != 0) {
        std::cerr << "glewInit error\n";
        glfwDestroyWindow(window);
        glfwTerminate();
    }

    glfwSwapInterval(1);


    // float positions[] = {
    //     100.0, 100.0, 0.0, 0.0,
    //     200.0, 100,0, 1.0, 0.0,
    //     200.0, 200.0, 1.0, 1.0,
    //     100.0, 200.0, 0.0, 1.0
    // };
    float positions[] = {
        0.5,  0.5,
        0.5, -0,5,
       -0.5, -0.5,
       -0.5,  0.5,
    };

    unsigned int indeces[] = {0, 1, 2, 2, 3, 0};

    // glEnable(GL_BLEND);
    // glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    std::cout << "Blending enable\n";

    VertexArray va{};
    VertexBuffer vb{positions, sizeof(positions)};
    VertexBufferLayout vbl{};
    vbl.pushf32(2, false);
    //vbl.pushf32(2, false);
    va.addBuffer(vb, vbl);

    IndexBuffer ib{indeces, sizeof(indeces)};

    std::cout << "Create VBO, VAO, IBO\n";

    Shader sh{"res/shaders/Basic.glsl"};
    sh.bind();
    sh.setUniformf4("u_Color", 0.8, 0.3, 0.8, 1.0);

    va.unbind();
    vb.unbind();
    ib.unbind();
    sh.unbind();

    float inc = 0.05f;
    float r = 0.0f;
    std::cout << "Start main loop" << '\n';
    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        sh.bind();
        sh.setUniformf4("u_Color", r, 0.3f, 0.8f, 1.0f);

        va.bind();
        ib.bind();

        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);

        if (r > 1.0f) {
            inc = -0.05f;
        } else if (r < 0.0f) {
            inc = 0.05;
        }

        r += inc;

        glfwSwapBuffers(window);
        glfwPollEvents();
        checkPoll(window);
        usleep(40000);
    }



    glfwDestroyWindow(window);
    glfwTerminate();
    std::cout << "End opengl app\n" ;
    return 0;
}

