#ifndef VERTEX_ARRAY_HPP
#define VERTEX_ARRAY_HPP
#include <GL/glew.h>
#include "glcall.hpp"

class VertexArray {
    unsigned int id;
public:    
    VertexArray(){
        GLCall(glGenVertexArrays(1, &id));
    }

    ~VertexArray() {
        GLCall(glDeleteVertexArrays(1, &id));
    }

    void bind() {
        GLCall(glBindVertexArray(id));
    }
    void unbind() {
        GLCall(glBindVertexArray(0));
    }

};

#endif //VERTEX_ARRAY_HPP
