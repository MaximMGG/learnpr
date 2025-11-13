#ifndef BUFFER_ARRAY_HPP
#define BUFFER_ARRAY_HPP
#include <GL/glew.h>

class BufferArray {
public:
    unsigned int id;
    BufferArray(int buffer_size, void *data) {
        glGenBuffers(1, &id);
        glBindBuffer(GL_ARRAY_BUFFER, id);
        glBufferData(GL_ARRAY_BUFFER, buffer_size, data, GL_STATIC_DRAW);
    }

    ~BufferArray() {
        glDeleteBuffers(1, &id);

    }
    void bind() {
        glBindBuffer(GL_ARRAY_BUFFER, id);
    }
    void unbind() {
        glBindBuffer(GL_ARRAY_BUFFER, 0);
    }
        

};

#endif //BUFFER_ARRAY_HPP
