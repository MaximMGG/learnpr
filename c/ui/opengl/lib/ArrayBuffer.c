#include "ArrayBuffer.h"

unsigned int arrayBufferCreate(u32 size, ptr data) {
    u32 VBO;
    GLCall(glGenBuffers(1, &VBO));
    GLCall(glBindBuffer(GL_ARRAY_BUFFER, VBO));
    GLCall(glBufferData(GL_ARRAY_BUFFER, size, data, GL_STATIC_DRAW));
    return VBO;
}

void arrayBufferBind(u32 VBO) {
    GLCall(glBindBuffer(GL_ARRAY_BUFFER, VBO));
}

void arrayBufferUnbind() {
    GLCall(glBindBuffer(GL_ARRAY_BUFFER, 0));
}

void arrayBufferDestroy(u32 *VBO) {
    GLCall(glDeleteBuffers(1, VBO));
}
