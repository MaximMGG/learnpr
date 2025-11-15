#ifndef ARRAY_BUFFER_H
#define ARRAY_BUFFER_H
#include <GL/glew.h>
#include <cstdext/core.h>

unsigned int arrayBufferCreate(u32 size, ptr data);
void arrayBufferBind(u32 VBO);
void arrayBufferUnbind();
void arrayBufferDestroy(u32 *VBO);

#endif //ARRAY_BUFFER_H
