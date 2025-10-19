#ifndef INDEX_BUFFER_HPP
#define INDEX_BUFFER_HPP
#include <GL/glew.h>

struct IndexBuffer {

    unsigned int rendererID = 0;
    unsigned int count = 0;

    IndexBuffer(unsigned *data, unsigned size);
    ~IndexBuffer();

    void bind();
    void unbind();

};

#endif
