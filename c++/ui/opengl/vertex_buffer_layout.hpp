#ifndef VERETEX_BUFFER_LAYOUT_HPP
#define VERETEX_BUFFER_LAYOUT_HPP
#include <GL/glew.h>
#include <vector>

struct VertexBufferElement {
    unsigned int count;
    unsigned int _type;
    bool normalized;

    VertexBufferElement(unsigned int count, unsigned int _type, bool normalized);
    ~VertexBufferElement();

    unsigned int bufferElementGetSize();
};


struct VertexBufferLayout {
    std::vector<VertexBufferElement> elements{};
    unsigned int stride{0};

    VertexBufferLayout();
    ~VertexBufferLayout();

    void pushf32(unsigned int count, bool normalized);
    void pushu32(unsigned int count, bool normalized);
    void pushu8(unsigned int count, bool normalized);
};

#endif
