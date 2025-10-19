#include "vertex_array.hpp"
#include <GL/glew.h>


VertexArray::VertexArray() {
    glGenVertexArrays(1, &this->rendererID);
}

VertexArray::~VertexArray() {
    glDeleteVertexArrays(1, &this->rendererID);
}

void VertexArray::addBuffer(VertexBuffer &vb, VertexBufferLayout &vbl) {
    this->bind();
    vb.bind();

    long offset = 0;
    int i = 0;

    for(auto e = vbl.elements.begin(); e != vbl.elements.end(); e++, i++) {
        glEnableVertexAttribArray(i);
        glVertexAttribPointer(i, e->count, e->_type, e->normalized, vbl.stride, (void *)offset);
        offset += e->count * e->bufferElementGetSize();
    }
}

void VertexArray::bind() {
    glBindVertexArray(this->rendererID);
}

void VertexArray::unbind() {
    glBindVertexArray(0);
}
