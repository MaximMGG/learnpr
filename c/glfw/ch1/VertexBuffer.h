#ifndef VERTEX_BUFFER_H
#define VERTEX_BUFFER_H
#include <cstdext/core.h>

typedef struct {
    u32 rendererID;
} VertexBuffer;


VertexBuffer VertexBufferCreate(const ptr data, u32 size);
void VertexBufferDestroy(VertexBuffer *vb);

void VertexBufferBind(VertexBuffer *vb);
void VertexBufferUnbind(VertexBuffer *vb);


#endif //VERTEX_BUFFER_H
