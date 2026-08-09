#include "renderer.h"
#include "shader.h"


Renderer rendererCreate() {
  Renderer r = {.objects = daCreate(ptr)};
  return r;
}

void rendererAddObject(Renderer *r, ptr object) {
  daAppend(r->objects, object);
}

void rendererDraw(Renderer *r) {
  for(i32 i = 0; i < DA_LEN(r->objects); i++) {
    u32 type = *cast(u32 *, r->objects[i]);
    switch(type) {
      case RECT: {
        programUse(r->rect_program);
        rectDraw(r->objects[i]);
      } break;
      case CIRCLE: {
        programUse(r->circle_program);
        circleDraw(r->objects[i]);
      } break;
    }
  }
}

void rendererDestroy(Renderer *r) {
  for(i32 i = 0; i < DA_LEN(r->objects); i++) {
    u32 type = *cast(u32 *, r->objects[i]);
    switch(type) {
      case RECT: {
        rectDestroy(*(Rect *)r->objects[i]);
      } break;
      case CIRCLE: {
        circleDestroy(*(Circle *)(r->objects[i]));
      } break;
    }
    DEALLOC(r->objects[i]);
  }
  daDestroy(r->objects);
}

void rendererClear(Renderer *r) {
  daClear(r->objects);
}
