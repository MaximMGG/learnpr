#ifndef VERTEX_BUFFER_HPP
#define VERTEX_BUFFER_HPP
#include "render.hpp"

class VertexBuffer {
public:
    unsigned int ID;
    VertexBuffer(void *data, unsigned int data_size) {
        GLCall(glGenBuffers(1, &ID));
        GLCall(glBindBuffer(GL_ARRAY_BUFFER, ID));
        GLCall(glBufferData(GL_ARRAY_BUFFER, data_size, data, GL_STATIC_DRAW));
    }

    ~VertexBuffer() {
        GLCall(glDeleteBuffers(1, &ID));
    }

    void bind() {
        GLCall(glBindBuffer(GL_ARRAY_BUFFER, ID));
    }
    void unbind() {
        GLCall(glBindBuffer(GL_ARRAY_BUFFER, 0));
    }
};


#endif
