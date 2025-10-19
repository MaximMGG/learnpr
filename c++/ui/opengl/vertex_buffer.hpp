#ifndef VERTEX_BUFFER_HPP
#define VERTEX_BUFFER_HPP
#include <GL/glew.h>


struct VertexBuffer {
    unsigned int rendererID;


    VertexBuffer(void *data, unsigned int size);
    ~VertexBuffer();
    void bind();
    void unbind();
    
};

#endif
