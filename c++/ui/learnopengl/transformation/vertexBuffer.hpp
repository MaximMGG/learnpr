#ifndef VERTEX_BUFFER_HPP
#define VERTEX_BUFFER_HPP

#include <GL/glew.h>

class VertexBuffer {
public:
  unsigned int id;

  VertexBuffer(void *data, unsigned int size) {
    glCreateBuffers(1, &this->id);
    glBindBuffer(GL_ARRAY_BUFFER, this->id);
    glBufferData(GL_ARRAY_BUFFER, size, data, GL_STATIC_DRAW);
  }

  ~VertexBuffer(){
    glDeleteBuffers(1, &id);
  }
  void bind() {
    glBindBuffer(GL_ARRAY_BUFFER, this->id);
  }
  void unbind() {
    glBindBuffer(GL_ARRAY_BUFFER, 0);
  }

};

#endif

