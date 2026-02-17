#ifndef VERTEX_ARRAY_HPP
#define VERTEX_ARRAY_HPP

#include <GL/glew.h>

class VertexArray {
  unsigned int id;

  VertexArray() {
    glCreateVertexArrays(1, &this->id);
    glBindVertexArray(this->id);
  }

  ~VertexArray() {
    glDeleteVertexArrays(1, &this->id);

  }
  void bind() {
    glBindVertexArray(this->id);
  }
  void unbind() {
    glBindVertexArray(0);
  }
};

#endif
