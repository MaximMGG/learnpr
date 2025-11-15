#ifndef ELEMENT_BUFFER_H
#define ELEMENT_BUFFER_H
#include <GL/glew.h>
#include <cstdext/core.h>

u32 elementBufferCreate(u32 size, ptr data);
void elementBufferBind(u32 EBO);
void elementBufferUnbind();
void elementBufferDestroy(u32 *EBO);






#endif //ELEMENT_BUFFER_H
