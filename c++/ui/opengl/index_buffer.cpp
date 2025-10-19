#include "index_buffer.hpp"

IndexBuffer::IndexBuffer(u32 *data, u32 size) {
    static_assert(sizeof(u32) == sizeof(GLuint));

    glGenBuffers(1, &this->rendererID);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, this->rendererID);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, size, data, GL_STATIC_DRAW);
    this->count = size / sizeof(typeof(*data));
}

IndexBuffer::~IndexBuffer(){
    glDeleteBuffers(1, &this->rendererID);
}

void IndexBuffer::bind() {
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, this->rendererID);

}
void IndexBuffer::unbind() {
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}
