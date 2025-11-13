#ifndef VERTEX_ARRAY_HPP
#define VERTEX_ARRAY_HPP
#include <GL/glew.h>

class VertexArray {
    unsigned int id;
public:    
    VertexArray(){
        glGenVertexArrays(1, &id);
    }

    ~VertexArray() {
        glDeleteVertexArrays(1, &id);
    }

    void bind() {
        glBindVertexArray(id);
    }
    void unbind() {
        glBindVertexArray(0);
    }

};

#endif //VERTEX_ARRAY_HPP
