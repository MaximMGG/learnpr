#include <cstdext/core.h>
#include <cstdext/container/list.h>
#include <stdio.h>


#define COUNT 2000000000

i32 main() {
  List *l = listCreate(I32);

  for(i32 i = 0; i < COUNT; i++) {
    listAppend(l, &i);
  }

  printf("List len: %ld, last item: %d\n", l->len, *cast(i32 *, listGet(l, COUNT - 1)));
  listDestroy(l);

  return 0;
}
