#include "vertex_buffer_layout.hpp"

VertexBufferElement::VertexBufferElement(u32 count, u32 _type, bool normalized) : count(count), _type(_type), normalized(normalized) {}
VertexBufferElement::~VertexBufferElement(){}

u32 VertexBufferElement::bufferElementGetSize() {
    switch(this->_type) {
        case GL_FLOAT: {
            return sizeof(GLfloat);
        } break;
        case GL_UNSIGNED_INT: {
            return sizeof(GLuint);
        } break;
        case GL_INT: {
            return sizeof(GLint);
        } break;
        case GL_UNSIGNED_BYTE: {
            return sizeof(GLbyte);
        } break;
        default: return 0;
    }
    return 0;
}


VertexBufferLayout::VertexBufferLayout() {
    stride = 0;
}

VertexBufferLayout::~VertexBufferLayout() {}

void VertexBufferLayout::pushf32(u32 count, bool normalized) {
    VertexBufferElement e{count, GL_FLOAT, normalized};
    this->elements.push_back(e);
    this->stride += e.bufferElementGetSize() * count;
}

void VertexBufferLayout::pushu32(u32 count, bool normalized) {
    VertexBufferElement e{count, GL_UNSIGNED_INT, normalized};
    this->elements.push_back(e);
    this->stride += e.bufferElementGetSize() * count;
}

void VertexBufferLayout::pushu8(u32 count, bool normalized) {
    VertexBufferElement e{count, GL_UNSIGNED_BYTE, normalized};
    this->elements.push_back(e);
    this->stride += e.bufferElementGetSize() * count;
}
