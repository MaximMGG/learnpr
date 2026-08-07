#include "circle.h"

Circle circleCreate(f32 x, f32 y, f32 r) {
  Circle c = {.x = x, .y = y, .r = r};

  c.circle_data[0] = x - r;
  c.circle_data[1] = y - r;

  c.circle_data[2] = x + r;
  c.circle_data[3] = y - r;

  c.circle_data[4] = x + r;
  c.circle_data[5] = y + r;

  c.circle_data[6] = x - r;
  c.circle_data[7] = y + r;

  c.circle_elements[0] = 0;
  c.circle_elements[1] = 1;
  c.circle_elements[2] = 2;
  c.circle_elements[3] = 3;
  c.circle_elements[4] = 1;
  c.circle_elements[5] = 2;

  glGenVertexArrays(1, &c.vao_id);
  glGenBuffers(1, &c.id);
  glGenBuffers(1, &c.element_id);
  glBindVertexArray(c.vao_id);
  glBindBuffer(GL_ARRAY_BUFFER, c.id);
  glBufferData(GL_ARRAY_BUFFER, sizeof(c.circle_data), c.circle_data, GL_STATIC_DRAW);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, c.element_id);
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(c.circle_elements), c.circle_elements, GL_STATIC_DRAW);

  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(f32), (void *)0);
  glEnableVertexAttribArray(0);

  return c;
}

void circleDraw(Circle *c) {
  glBindVertexArray(c->vao_id);
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, c->element_id);
  glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null);
}

void circleDestroy(Circle c) {
  glDeleteVertexArrays(1, &c.vao_id);
  glDeleteBuffers(1, &c.id);
  glDeleteBuffers(1, &c.element_id);
}
