#include "VertexArray.h"

unsigned int vertexArrayCreate() {
    unsigned int VAO;
    glGenVertexArrays(1, &VAO);
    return VAO;
}

void vertexArrayBind(unsigned int VAO) {
    glBindVertexArray(VAO);
}

void vertexArrayUnbind() {
    glBindVertexArray(0);
}

void vertexArrayDestroy(unsigned int *VAO) {
    glDeleteVertexArrays(1, VAO);
}
