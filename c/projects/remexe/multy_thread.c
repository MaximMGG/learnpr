#include <stdio.h>
#include <pthread.h>
#include <cstdext/core.h>
#include <stdatomic.h>

_Atomic u64 total_sum = 0;
#define COUNT 50000000


void *sum(void *p) {
  u32 local_sum = 0;
  for (i32 i = 0; i < COUNT; i++) {
    local_sum++;
  }
  total_sum += local_sum;  
  return null;
}

int main() {
  pthread_t workers[6];
  for (i32 i = 0; i < 6; i++) {
    pthread_create(&workers[i], null, sum, null);
  }
  for (i32 i = 0; i < 6; i++) {
    pthread_join(workers[i], null);
  }
  printf("Total sum %lu\n", total_sum);

  return 0;  
}
