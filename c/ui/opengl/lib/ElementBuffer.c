#include "ElementBuffer.h"

u32 elementBufferCreate(u32 size, ptr data) {
    u32 EBO;
    GLCall(glGenBuffers(1, &EBO));
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO));
    GLCall(glBufferData(GL_ELEMENT_ARRAY_BUFFER, size, data, GL_STATIC_DRAW));
    return EBO;
}

void elementBufferBind(u32 EBO) {
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO));
}
void elementBufferUnbind() {
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0));
}
void elementBufferDestroy(u32 *EBO) {
    GLCall(glDeleteBuffers(1, EBO));
}
