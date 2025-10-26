#ifndef VERTEX_ARRAY_HPP
#define VERTEX_ARRAY_HPP
#include "render.hpp"


class VertexArray {
public:
    unsigned int ID;

    VertexArray() {
        GLCall(glGenVertexArrays(1, &ID));
        GLCall(glBindVertexArray(ID));
    }

    ~VertexArray() {
        GLCall(glDeleteVertexArrays(1, &ID));
    }

    void bind() {
        GLCall(glBindVertexArray(ID));
    }

    void unbind() {
        GLCall(glBindVertexArray(0));
    }

};

#endif //VERTEX_ARRAY_HPP
