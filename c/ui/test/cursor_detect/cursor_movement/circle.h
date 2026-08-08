#ifndef CIRCLE_H
#define CIRCLE_H

#include <cstdext/core.h>
#include <glad/glad.h>

typedef struct {
  u32 vao_id;
  u32 id;
  u32 element_id;

  f32 x, y;
  f32 r;

  f32 circle_data[8]; 
  u32 circle_elements[6];
  u32 program;
} Circle;


Circle circleCreate(f32 x, f32 y, f32 r, u32 prog);
void circleDraw(Circle *c);
void circleDestroy(Circle c);


#endif //CIRCLE_H
