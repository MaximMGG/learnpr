#include "ArrayBuffer.h"

unsigned int arrayBufferCreate(u32 size, ptr data) {
    u32 VBO;
    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, size, data, GL_STATIC_DRAW);
    return VBO;
}

void arrayBufferBind(u32 VBO) {
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
}

void arrayBufferUnbind() {
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}

void arrayBufferDestroy(u32 *VBO) {
    glDeleteBuffers(1, VBO);
}
