#include "vertex_buffer_layout.hpp"

VertexBufferElement::VertexBufferElement(unsigned int count, unsigned int _type, bool normalized) : count(count), _type(_type), normalized(normalized) {}
VertexBufferElement::~VertexBufferElement(){}

unsigned int VertexBufferElement::bufferElementGetSize() {
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

void VertexBufferLayout::pushf32(unsigned int count, bool normalized) {
    VertexBufferElement e{count, GL_FLOAT, normalized};
    this->elements.push_back(e);
    this->stride += e.bufferElementGetSize() * count;
}

void VertexBufferLayout::pushu32(unsigned int count, bool normalized) {
    VertexBufferElement e{count, GL_UNSIGNED_INT, normalized};
    this->elements.push_back(e);
    this->stride += e.bufferElementGetSize() * count;
}

void VertexBufferLayout::pushu8(unsigned int count, bool normalized) {
    VertexBufferElement e{count, GL_UNSIGNED_BYTE, normalized};
    this->elements.push_back(e);
    this->stride += e.bufferElementGetSize() * count;
}
