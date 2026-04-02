#ifndef VERTEX_ARRAY_H
#define VERTEX_ARRAY_H
#include "VertexBuffer.h"
#include "VertexBufferLayout.h"

typedef struct {
    u32 rendererID;

} VertexArray;

VertexArray VertexArrayCreate();
void VertexArrayDestroy(VertexArray *va);
void VertexArrayAddBuffer(VertexArray *va, VertexBuffer *vb, VertexBufferLayout *layout);

void VertexArrayBind(VertexArray *va);
void VertexArrayUnbind(VertexArray *va);
#endif //VERTEX_ARRAY_H
