#ifndef VERTEX_ARRAY_HPP
#define VERTEX_ARRAY_HPP
#include <GL/glew.h>
#include "vertex_buffer.hpp"
#include "vertex_buffer_layout.hpp"

#define u32 unsigned int
struct VertexArray {
    u32 rendererID;

    VertexArray();
    ~VertexArray();

    void addBuffer(VertexBuffer &vb, VertexBufferLayout vbl);
    void bind();
    void unbind();
};

#endif
