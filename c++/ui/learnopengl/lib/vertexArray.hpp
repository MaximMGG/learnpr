#ifndef VERTEX_ARRAY_HPP
#define VERTEX_ARRAY_HPP
#include <GL/glew.h>
#include "glcall.hpp"
#include <vector>
#include "types.hpp"

class Element {
public:
  int count;
  int size;
  Element(int count, int size) : count(count), size(size){}
  ~Element(){}
};

class VertexArray {
private:
    unsigned int id;
    std::vector<Element> elements;
    int stride = 0;

public:    
    VertexArray(){
        GLCall(glGenVertexArrays(1, &id));
        GLCall(glBindVertexArray(id));
    }

    ~VertexArray() {
        GLCall(glDeleteVertexArrays(1, &id));
    }

    void bind() {
        GLCall(glBindVertexArray(id));
    }
    void unbind() {
        GLCall(glBindVertexArray(0));
    }

    void addf32(int count) {
      Element e(count, sizeof(f32) * count);
      elements.push_back(e);
      stride += count * sizeof(f32);
    }

    void setStride(int stride) {
      this->stride = stride;
    }

    void process() {
      long offset = 0;
      for(i32 i = 0; i < elements.size(); i++) {
        Element e = elements[i];
        glVertexAttribPointer(i, e.count, GL_FLOAT, GL_FALSE, stride, (void *)offset);
        offset += e.size;
        glEnableVertexAttribArray(i);
      }
    }
};

#endif //VERTEX_ARRAY_HPP
