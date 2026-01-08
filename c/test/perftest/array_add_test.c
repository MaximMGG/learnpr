#include <stdio.h>
#include <cstdext/core.h>

i32  *add_to_arr(i32 *arr, i32 num) {
  da_append(arr, num);
  return arr;
}


#define COUNT 1000000

int main() {

  i32 *arr = da_create(i32);

  for (i32 i = 0; i < COUNT; i++) {
    arr = add_to_arr(arr, i);
  }

  u64 sum = 0;
  for(i32 i = 0; i < DA_LEN(arr); i++) {
    sum += arr[i];
  }
  printf("Sum is: %ld\n", sum);

  da_destroy(arr);
  return 0;
}
