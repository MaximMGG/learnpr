#ifndef VERTEX_BUFFER_HPP
#define VERTEX_BUFFER_HPP
#include "render.hpp"

class VertexBuffer {
public:
    unsigned int ID;
    VertexBuffer(void *data, unsigned int data_size) {
        glGenBuffers(1, &ID);
        glBindBuffer(GL_ARRAY_BUFFER, ID);
        glBufferData(GL_ARRAY_BUFFER, data_size, data, GL_STATIC_DRAW);
    }

    ~VertexBuffer() {
        glDeleteBuffers(1, &ID);
    }

    void bind() {
        glBindBuffer(GL_ARRAY_BUFFER, ID);
    }
    void unbind() {
        glBindBuffer(GL_ARRAY_BUFFER, 0);
    }
};


#endif
