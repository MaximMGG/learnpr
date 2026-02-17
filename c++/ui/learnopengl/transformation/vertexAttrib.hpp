#ifndef VERTEX_ATTRIB_HPP
#define VERTEX_ATTRIB_HPP

#include <GL/glew.h>
#include <vector>


class Element {
public:
  int count;
  int size;

  Element(int count, int size) : count(count), size(size) {}
  ~Element() {}
};

class VertexAttrib {
public:
  std::vector<Element> elements;
  int stride = 0;

  VertexAttrib(){}
  ~VertexAttrib(){}

  void addf32(int count) {
    Element tmp(count, sizeof(float) * count);
    this->elements.push_back(tmp);
    stride += count * sizeof(float);
  }
  void process() {
    unsigned long offset = 0;
    for(int i = 0; i < this->elements.size(); i++) {
      Element tmp = this->elements[i];
      glVertexAttribPointer(i, tmp.count, GL_FLOAT, GL_FALSE, this->stride, (void *)offset);
      glEnableVertexAttribArray(i);
      offset += tmp.size;
    }
  }

};

#endif
