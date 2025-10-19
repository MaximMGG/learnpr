#ifndef VERETEX_BUFFER_LAYOUT_HPP
#define VERETEX_BUFFER_LAYOUT_HPP
#include <GL/glew.h>
#include <vector>

#define u32 unsigned int

struct VertexBufferElement {
    u32 count;
    u32 _type;
    bool normalized;

    VertexBufferElement(u32 count, u32 _type, bool normalized);
    ~VertexBufferElement();

    u32 bufferElementGetSize();
};


struct VertexBufferLayout {
    std::vector<VertexBufferElement> elements{};
    u32 stride{0};

    VertexBufferLayout();
    ~VertexBufferLayout();

    void pushf32(u32 count, bool normalized);
    void pushu32(u32 count, bool normalized);
    void pushu8(u32 count, bool normalized);
};

#endif
