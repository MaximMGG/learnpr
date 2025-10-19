#include "vertex_buffer.hpp"

VertexBuffer::VertexBuffer(void *data, u32 size) {
    glGenBuffers(1, &this->rendererID);
    glBindBuffer(GL_ARRAY_BUFFER, this->rendererID);
    glBufferData(GL_ARRAY_BUFFER, size, data, GL_STATIC_DRAW);
}

VertexBuffer::~VertexBuffer() {
    glDeleteBuffers(1, &this->rendererID);
}

void VertexBuffer::bind() {
    glBindBuffer(GL_ARRAY_BUFFER, this->rendererID);

}
void VertexBuffer::unbind() {
    glBindBuffer(GL_ARRAY_BUFFER, 0);
}

