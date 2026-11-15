
#include <cstdext/core.h>
#include <stdio.h>

typedef struct {
  i32 *data;
  u32 len;
  u32 cap;
} TList;


TList *tlistCreate() {
  TList *t = make(TList);
  t->cap = 8;
  t->data = make_many(i32 , t->cap);
  t->len = 0;
  return t;
}


void tlistDestroy(TList **t) {
  DEALLOC((*t)->data);
  DEALLOC((*t));
}

void raiiDestroyTList(TList **t) {
  DEALLOC((*t)->data);
  DEALLOC((*t));
}


#define auto_free(type) __attribute__((cleanup(raiiDestroy ## type)))type


i32 main() {
  __attribute__((cleanup(tlistDestroy)))
  TList *t = tlistCreate();
  printf("Len: %d\n", t->len);


  auto_free(TList) *a = tlistCreate();
  

  return 0;
}
