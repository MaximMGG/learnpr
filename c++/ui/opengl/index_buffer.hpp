#ifndef INDEX_BUFFER_HPP
#define INDEX_BUFFER_HPP
#include <GL/glew.h>

#define u32 unsigned int

struct IndexBuffer {

    u32 rendererID = 0;
    u32 count = 0;

    IndexBuffer(u32 *data, u32 size);
    ~IndexBuffer();

    void bind();
    void unbind();

};

#endif
