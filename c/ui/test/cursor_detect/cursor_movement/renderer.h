#ifndef RENDERER_H
#define RENDERER_H

#include <cstdext/core.h>
#include "circle.h"
#include "rect.h"
#include "shape_type.h"

typedef struct {
  DA_ARR(ptr) objects;
  u32 rect_program;
  u32 circle_program;
} Renderer;


Renderer rendererCreate();
void     rendererAddObject(Renderer *r, ptr object);
void     rendererDraw(Renderer *r);
void     rendererDestroy(Renderer *r);
void     rendererClear(Renderer *r);

#endif //RENDERER_H
