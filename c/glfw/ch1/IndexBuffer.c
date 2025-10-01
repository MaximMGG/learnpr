#include "IndexBuffer.h"
#include "renderer.h"
#include <GL/glew.h>
#include <stdio.h>
#include <assert.h>


IndexBuffer IndexBufferCreate(const u32 *data, u32 count) {
    IndexBuffer ib = {};

    static_assert(sizeof(u32) == sizeof(GLuint), "u32 not equals to GLuint");
    GLCall(glGenBuffers(1, &ib.rendererID));
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ib.rendererID));
    GLCall(glBufferData(GL_ELEMENT_ARRAY_BUFFER, count * sizeof(u32), data, GL_STATIC_DRAW));
    ib.count = count;
    return ib;
}

void IndexBufferDestroy(IndexBuffer *ib) {
    GLCall(glDeleteBuffers(1, &ib->rendererID));
}

void IndexBufferBind(IndexBuffer *ib) {
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ib->rendererID));
}
void IndexBufferUnbind(IndexBuffer *ib) {
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0));
}
