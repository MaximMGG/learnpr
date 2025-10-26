#ifndef VERTEX_ATTIRB_HPP
#define VERTEX_ATTIRB_HPP
#include "render.hpp"
#include <vector>

class Element {
public:
    int count;
    int size;

    Element(int count, int size) : count(count), size(size){}
    ~Element(){}
};

class VertexAttrib {
public:
    std::vector<Element> elements;
    int stride = 0;

    VertexAttrib(){}
    ~VertexAttrib(){}

    void addf32(int count) {
        Element tmp(count, sizeof(float) * count);
        elements.push_back(tmp);
        stride += (count * sizeof(float));
    }

    void process() {
        auto it = elements.begin();
        unsigned long offset = 0;

        for(int i = 0; i < elements.size(); i++) {
            Element tmp = elements[i];
            GLCall(glVertexAttribPointer(i, tmp.count, GL_FLOAT, GL_FALSE, stride, (void *)offset));
            GLCall(glEnableVertexAttribArray(i));
            offset += tmp.size;
        }
    }
};

#endif
