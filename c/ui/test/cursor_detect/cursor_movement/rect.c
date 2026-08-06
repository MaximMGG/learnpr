#include "rect.h"
#include <string.h>

f32 vertices[] = {
  0.0f, 0.0f,
  100.f, 0.0f,
  100.0f, 200.0f,

  0.0f, 0.0f,
  0.0f, 200.0f,
  100.0f, 200.0f,
};

Rect rectCreate(i32 x, i32 y, i32 width, i32 height) {
  Rect r = {.x = x, .y = y, .width = width, .height = height};

  r.rect_data[0] = F32(x); //100
  r.rect_data[1] = F32(y); //100
  
  r.rect_data[2] = F32(x + width); //200
  r.rect_data[3] = F32(y); //100
  
  r.rect_data[4] = F32(x); //100
  r.rect_data[5] = F32(y + height); //200
  
  r.rect_data[6] = F32(x + width); //200
  r.rect_data[7] = F32(y + height); //200

  r.rect_elements[0] = 0;
  r.rect_elements[1] = 1;
  r.rect_elements[2] = 2;
  r.rect_elements[3] = 3;
  r.rect_elements[4] = 1;
  r.rect_elements[5] = 2;


  glGenVertexArrays(1, &r.vao_id);
  glBindVertexArray(r.vao_id);
  glGenBuffers(1, &r.id);
  glBindBuffer(GL_ARRAY_BUFFER, r.id);
  glBufferData(GL_ARRAY_BUFFER, sizeof(r.rect_data), &r.rect_data[0], GL_STATIC_DRAW);

  glGenBuffers(1, &r.element_id);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, r.element_id);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(r.rect_elements), &r.rect_elements[0], GL_STATIC_DRAW);

  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  return r;
}
void rectDestroy(Rect r) {
  glDeleteVertexArrays(1, &r.vao_id);
  glDeleteBuffers(1, &r.id);
  glDeleteBuffers(1, &r.element_id);
}

void rectSetColor(Rect *r, f32 color[4]) {
  memcpy(r->rect_color, &color[0], 4 * sizeof(f32));
}

void rectDraw(Rect *r) {
  glBindVertexArray(r->vao_id);
  glBindBuffer(GL_ARRAY_BUFFER, r->id);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, r->element_id);
  glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null);
}
