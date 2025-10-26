#ifndef VERTEX_ARRAY_HPP
#define VERTEX_ARRAY_HPP
#include "render.hpp"


class VertexArray {
public:
    unsigned int ID;

    VertexArray() {
        glGenVertexArrays(1, &ID);
        glBindVertexArray(ID);
    }

    ~VertexArray() {
        glDeleteVertexArrays(1, &ID);
    }

    void bind() {
        glBindVertexArray(ID);
    }

    void unbind() {
        glBindVertexArray(0);
    }

};

#endif //VERTEX_ARRAY_HPP
