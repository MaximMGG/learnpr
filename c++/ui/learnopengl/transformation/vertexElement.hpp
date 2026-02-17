#ifndef VERTEX_ELEMENT_HPP
#define VERTEX_ELEMENT_HPP

#include <GL/glew.h>

class VertexElement {
public:
  unsigned int id;

  VertexElement(void *data, unsigned int size) {
    glCreateBuffers(1, &this->id);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, this->id);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, size, data, GL_STATIC_DRAW);
  }
  ~VertexElement() {
    glDeleteBuffers(1, &this->id);
  }
  void bind() {
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, this->id);
  }
  void unbind() {
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
  }

};

#endif
