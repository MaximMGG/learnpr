#include "VertexArray.h"

unsigned int vertexArrayCreate() {
    unsigned int VAO;
    GLCall(glGenVertexArrays(1, &VAO));
    return VAO;
}

void vertexArrayBind(unsigned int VAO) {
    GLCall(glBindVertexArray(VAO));
}

void vertexArrayUnbind() {
    GLCall(glBindVertexArray(0));
}

void vertexArrayDestroy(unsigned int *VAO) {
    GLCall(glDeleteVertexArrays(1, VAO));
}
