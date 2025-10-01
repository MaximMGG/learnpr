#include "VertexBuffer.h"
#include "renderer.h"
#include <GL/glew.h>
#include <stdio.h>



VertexBuffer VertexBufferCreate(const ptr data, u32 size) {
    VertexBuffer vb = {};

    GLCall(glGenBuffers(1, &vb.rendererID));
    GLCall(glBindBuffer(GL_ARRAY_BUFFER, vb.rendererID));
    GLCall(glBufferData(GL_ARRAY_BUFFER, size, data, GL_STATIC_DRAW));

    return vb;
}

void VertexBufferDestroy(VertexBuffer *vb) {
    GLCall(glDeleteBuffers(1, &vb->rendererID));
}

void VertexBufferBind(VertexBuffer *vb) {
    GLCall(glBindBuffer(GL_ARRAY_BUFFER, vb->rendererID));
}
void VertexBufferUnbind(VertexBuffer *vb) {
    GLCall(glBindBuffer(GL_ARRAY_BUFFER, 0));
}
