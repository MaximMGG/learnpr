#ifndef INDEX_BUFFER_H
#define INDEX_BUFFER_H
#include <cstdext/core.h>

typedef struct {
    u32 rendererID;
    u32 count;
} IndexBuffer;

IndexBuffer IndexBufferCreate(const u32 *data, u32 count);
void IndexBufferDestroy(IndexBuffer *vb);

void IndexBufferBind(IndexBuffer *vb);
void IndexBufferUnbind(IndexBuffer *vb);


#endif //INDEX_BUFFER_H
