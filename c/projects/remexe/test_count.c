#include <stdio.h>
#include <cstdext/core.h>
#include <stdatomic.h>

#define COUNT 50000000

_Atomic u64 total_sum;

int main() {
  for(i32 i = 0; i < COUNT * 6; i++) {
    total_sum++;
  }
  printf("Total sum %lu\n", total_sum);
  return 0;  
}
