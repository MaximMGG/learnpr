#include <cstdext/container/map.h>
#include <cstdext/core.h>
#include <stdio.h>

#define COUNT 1000000

int main() {
  map *m = map_create(I32, U64, null, null);

  i32 k = 1;
  u64 val = 3;

  for(i32 i = 0; i < COUNT; i++) {
    map_put(m, &k, &val);
    k++;
    val += 123;
  }

  iterator *it = map_iterator(m);
  KV kv = map_it_next(it);
  u64 total_sum = 0;
  while(kv.key != null) {
    total_sum += *(u64 *)kv.val;
    kv = map_it_next(it);
  }

  printf("Total sum: %ld\n", total_sum);


  map_it_destroy(it);
  map_destroy(m);
  return 0;
}
