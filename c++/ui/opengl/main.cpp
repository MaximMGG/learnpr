#include <iostream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <GL/gl.h>
#include "vertex_array.hpp"
#include "vertex_buffer.hpp"
#include "vertex_buffer_layout.hpp"
#include "index_buffer.hpp"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>


#define u32 unsigned int

#define WIDTH 1280
#define HEIGHT 720

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


    float positions[] = {
        100.0, 100.0, 0.0, 0.0,
        200.0, 100,0, 1.0, 0.0,
        200.0, 200.0, 1.0, 1.0,
        100.0, 200.0, 0.0, 1.0
    };

    u32 indeces[] = {0, 1, 2, 2, 3, 0};

    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    std::cout << "Blending enable\n";

    VertexArray va{};
    VertexBuffer vb{positions, sizeof(positions)};
    VertexBufferLayout vbl{};
    vbl.pushf32(2, false);
    vbl.pushf32(2, false);
    va.addBuffer(vb, vbl);

    IndexBuffer ib{indeces, sizeof(indeces)};

    std::cout << "Create VBO, VAO, IBO\n";




    glfwTerminate();
    std::cout << "End opengl app\n" ;
    return 0;
}

