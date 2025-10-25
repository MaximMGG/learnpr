#ifndef DRAWING_HPP
#define DRAWING_HPP
#include <GL/glew.h>

#include <vector>
#include <cmath>

std::vector<float> drawCircle(float x, float y, float radius, int sides);
unsigned int createVertexBufferObject(std::vector<float> &vertices);
unsigned int createVertexArrayObject();
void renderCircle(unsigned int VAO, unsigned int VBO, std::vector<float> &vertices, unsigned int mode);


#endif
