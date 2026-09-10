#include <mh/containers/list.hpp>
#include <stdio.h>

#define COUNT 2000000000

i32 main() {

  List<i32> l;

  for (i32 i = 0; i < COUNT; i++) {
    l.append(i);
  }

  printf("Len: %d, last item: %d\n", l.len, l[COUNT - 1]);
  return 0;
}
