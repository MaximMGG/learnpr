#ifndef VERTEX_ARRAY_H
#define VERTEX_ARRAY_H
#include <GL/glew.h>

unsigned int vertexArrayCreate();
void vertexArrayBind(unsigned int VAO);
void vertexArrayUnbind();
void vertexArrayDestroy(unsigned int *VAO);

#endif //VERTEX_ARRAY_H
