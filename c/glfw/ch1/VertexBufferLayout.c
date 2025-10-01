#include "VertexBufferLayout.h"
#include <GL/glew.h>

VertexBufferLayout VertexBufferLayoutCreate() {
    VertexBufferLayout vbl = {};
    vbl.elements = da_create(VertexBufferElement);
    vbl.stride = 0;
    return vbl;
}

u32 VertexBufferElementGetSize(u32 type) {
    switch(type) {
        case GL_FLOAT: return sizeof(GLfloat);
        case GL_UNSIGNED_INT: return sizeof(GLuint);
        case GL_INT: return sizeof(GLint);
        case GL_UNSIGNED_BYTE: return sizeof(GLbyte);
    }
    return 0;
}
void VertexBufferLayoutDestroy(VertexBufferLayout *vbl) {
    da_destroy(vbl->elements);
    (void) vbl;
}

void VertexBufferLayoutPushf32(VertexBufferLayout *vbl, u32 count, bool normalized) {
    da_append(vbl->elements, ((VertexBufferElement){.count = count, .type = GL_FLOAT, .normalized = false}));
    vbl->stride += VertexBufferElementGetSize(GL_FLOAT) * count;
}

void VertexBufferLayoutPushu32(VertexBufferLayout *vbl, u32 count, bool normalized) {
    da_append(vbl->elements, ((VertexBufferElement){.count = count, .type = GL_UNSIGNED_INT, .normalized = false}));
    vbl->stride += VertexBufferElementGetSize(GL_UNSIGNED_INT) * count;
}

void VertexBufferLayoutPushu8(VertexBufferLayout *vbl, u32 count, bool normalized) {
    da_append(vbl->elements, ((VertexBufferElement){.count = count, .type = GL_UNSIGNED_BYTE, .normalized = true}));
    vbl->stride += VertexBufferElementGetSize(GL_UNSIGNED_BYTE) * count;
}





