#include <stdio.h>
#include <cstdext/container/map.h>
#include <cstdext/core.h>
#include <string.h>



bool increment_key(char *key, int key_len) {
  i32 i = key_len - 1;
  while(true) {
    if (key[i] < '9') {
      key[i] += 1;
      break;
    } else {
      key[i] = '0';
      i--;
    }
  }
  if (key[3] == '1') {
    return false;
  }
  return true;
}

int main() {

  map *m = map_create(STR, I32, null, null);
  char *key = malloc(10);
  memset(key, 0, 10);
  strcpy(key, "Key000000");
  i32 val = 1;
  while(increment_key(key, 9)) {
    map_put(m, str_copy(key), &val);
    val++;
  }

  iterator *it = map_iterator(m);
  i64 values = 0;
  while(map_it_next(it)) {
    values++;
    printf("Key -> %s, Val -> %d\n", (str)it->key, *(i32 *)it->val);
    dealloc(it->key);
  }
  printf("Values - %ld\n", values);

  map_it_destroy(it);
  dealloc(key);
  map_destroy(m);
  return 0;
}
