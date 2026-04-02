#include "../vgl.h"
#include "../LoadShaders.h"
#include <stdio.h>

enum VAO_IDs {Triangles, NumVAOs};
enum Buffer_IDs {ArrayBuffer, NumBuffers};
enum Attrib_IDs {vPosition = 0};

GLuint VAOs[NumVAOs];
GLuint Buffers[NumBuffers];

const GLuint NumVertices = 6;

void init(void) {

    static const GLfloat vertices[6][2] = {
        {-0.90,  -0.90},
        { 0.85,  -0.90},
        {-0.90,   0.85},
        { 0.90,  -0.85},
        { 0.90,   0.90},
        {-0.85,   0.90},
    };

    glCreateBuffers(NumBuffers, Buffers);
    glNamedBufferStorage(Buffers[ArrayBuffer], sizeof(vertices), vertices, 0);

    ShaderInfo shaders[] = {
        { GL_VERTEX_SHADER, "triangles.vert"},
        { GL_FRAGMENT_SHADER, "triangles.frag"},
        { GL_NONE, NULL}
    };

    GLuint program = LoadShaders(shaders);
    glUseProgram(program);
    glGenVertexArrays(NumVAOs, VAOs);
    glBindVertexArray(VAOs[Triangles]);
    glBindBuffer(GL_ARRAY_BUFFER, Buffers[ArrayBuffer]);
    glVertexAttribPointer(vPosition, 2, GL_FLOAT, GL_FALSE, 0, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(vPosition);
}

void display(void) {
    static const float black[] = {0.0f, 0.0f, 0.0f, 0.0f};
    glClearBufferfv(GL_COLOR, 0, black);
    glBindVertexArray(VAOs[Triangles]);
    glDrawArrays(GL_TRIANGLES, 0, NumVertices);
}

int main(int argc, char **argv) {

    glfwInit();

    GLFWwindow *win = glfwCreateWindow(640, 480, "Triagnles", NULL, NULL);

    glfwMakeContextCurrent(win);

    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        fprintf(stderr, "Cant load glad\n");
        glfwDestroyWindow(win);
        glfwTerminate();
    }
    init();
    while(!glfwWindowShouldClose(win)) {
        display();
        glfwSwapBuffers(win);
        glfwPollEvents();
    }

    glfwDestroyWindow(win);
    glfwTerminate();
    return 0;
}
