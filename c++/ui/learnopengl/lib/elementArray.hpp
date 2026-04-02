#ifndef ELEMENT_ARRAY_BUFFER_HPP
#define ELEMENT_ARRAY_BUFFER_HPP
#include "types.hpp"
#include "glcall.hpp"
#include <GL/glew.h>


class ElementArray {
public:
  u32 id;

  ElementArray(u32 size, void *data) {
    GLCall(glGenBuffers(1, &id));
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, id));
    GLCall(glBufferData(GL_ELEMENT_ARRAY_BUFFER, size, data, GL_STATIC_DRAW));
  }

  ~ElementArray() {
    GLCall(glDeleteBuffers(1, &id));
  };

  void bind() {
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, id));
  }
  void unbind() {
    GLCall(glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0));
  }
};

#endif //ELEMENT_ARRAY_BUFFER_HPP
