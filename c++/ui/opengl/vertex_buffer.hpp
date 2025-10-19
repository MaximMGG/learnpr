#ifndef VERTEX_BUFFER_HPP
#define VERTEX_BUFFER_HPP
#include <GL/glew.h>

#define u32 unsigned int


struct VertexBuffer {
    u32 rendererID;


    VertexBuffer(void *data, u32 size);
    ~VertexBuffer();
    void bind();
    void unbind();
    
};

#endif
