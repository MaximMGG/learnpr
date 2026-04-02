#ifndef VERTEX_BUFFER_LAYOUT_H
#define VERTEX_BUFFER_LAYOUT_H

#include <cstdext/core/array.h>

typedef struct {
    u32 count;
    u32 type;
    bool normalized;
} VertexBufferElement;

u32 VertexBufferElementGetSize(u32 type);


typedef struct {
    VertexBufferElement *elements; //dyn_arr
    u32 stride;
}VertexBufferLayout;

VertexBufferLayout VertexBufferLayoutCreate();
void VertexBufferLayoutDestroy(VertexBufferLayout *vbl);

void VertexBufferLayoutPushf32(VertexBufferLayout *vbl, u32 count, bool normalized);
void VertexBufferLayoutPushu32(VertexBufferLayout *vbl, u32 count, bool normalized);
void VertexBufferLayoutPushu8(VertexBufferLayout *vbl, u32 count, bool normalized);


#endif //VERTEX_BUFFER_LAYOUT_H

