#ifndef BUFFER_ARRAY_HPP
#define BUFFER_ARRAY_HPP
#include <GL/glew.h>
#include "glcall.hpp"

class BufferArray {
public:
    unsigned int id;
    BufferArray(int buffer_size, void *data) {
        GLCall(glGenBuffers(1, &id));
        GLCall(glBindBuffer(GL_ARRAY_BUFFER, id));
        GLCall(glBufferData(GL_ARRAY_BUFFER, buffer_size, data, GL_STATIC_DRAW));
    }

    ~BufferArray() {
        GLCall(glDeleteBuffers(1, &id));

    }
    void bind() {
        GLCall(glBindBuffer(GL_ARRAY_BUFFER, id));
    }
    void unbind() {
        GLCall(glBindBuffer(GL_ARRAY_BUFFER, 0));
    }
        

};
#endif //BUFFER_ARRAY_HPP

