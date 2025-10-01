#include "VertexArray.h"
#include "renderer.h"
#include <GL/glew.h>
#include <stdio.h>

VertexArray VertexArrayCreate() {
    VertexArray va = {};
    GLCall(glGenVertexArrays(1, &va.rendererID));
    return va;
}

void VertexArrayDestroy(VertexArray *va) {
    GLCall(glDeleteVertexArrays(1, &va->rendererID));
}

void VertexArrayBind(VertexArray *va) {
    GLCall(glBindVertexArray(va->rendererID));
}

void VertexArrayUnbind(VertexArray *va) {
    GLCall(glBindVertexArray(0));
}

void VertexArrayAddBuffer(VertexArray *va, VertexBuffer *vb, VertexBufferLayout *layout) {
    VertexArrayBind(va);
    VertexBufferBind(vb);

    VertexBufferElement *elements = layout->elements;
    u64 offset = 0;
    for(u32 i = 0; i < DA_LEN(elements); i++) {
        GLCall(glEnableVertexAttribArray(i));
        GLCall(glVertexAttribPointer(i, elements[i].count, 
                    elements[i].type, elements[i].normalized, layout->stride, (ptr)offset));
        offset += elements[i].count * VertexBufferElementGetSize(elements[i].type);
    }
}
