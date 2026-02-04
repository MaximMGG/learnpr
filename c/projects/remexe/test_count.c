#include <stdio.h>
#include <cstdext/core.h>
#include <stdatomic.h>

#define COUNT 50000000

_Atomic u64 total_sum;

int main() {
  for (i32 i = 0; i < 6; i++) {
    u64 local_sum = 0;
    for (i32 j = 0; j < COUNT; j++) {
      local_sum++;
    }
    total_sum += local_sum;
  }  
  printf("Total sum %lu\n", total_sum);
  return 0;  
}
