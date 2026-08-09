#ifndef RECT_H
#define RECT_H

#include <cstdext/core.h>
#include <glad/glad.h>


typedef struct {
  u32 type;
  i32 x;
  i32 y;
  i32 width;
  i32 height;
  u32 vao_id;
  u32 id;
  u32 element_id;
  f32 rect_data[8];
  u32 rect_elements[6];
  f32 rect_color[4];
} Rect;


Rect rectCreate(i32 x, i32 y, i32 width, i32 height);
void rectSetColor(Rect *r, f32 color[4]);
void rectDestroy(Rect r);
void rectDraw(Rect *r);


#endif //RECT_H
