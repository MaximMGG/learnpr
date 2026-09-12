#include <cstdext/core.h>
#include <stdio.h>


#define COUNT 2000000000

i32 main() {

  DA_ARR(i32) arr = daCreate(i32);

  for(i32 i = 0; i < COUNT; i++) {
    daAppend(arr, i);
  }


  printf("Len: %ld, last item: %d\n", DA_LEN(arr), arr[COUNT - 1]);

  daDestroy(arr);

  return 0;
}
