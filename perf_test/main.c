#include <stdio.h>
#include <string.h>
#include <string.h>
#include <cstdext/core.h>
#include <cstdext/container/map.h>

bool increaseKey(str key, u32 len) {
  if (key[3] == '9') {
    return false;
  }
  i32 i = len - 1;
  while(true) {
    if (key[i] == '9') {
      key[i] = '0';
      i--;
    } else {
      key[i]++;
      break;
    }
  }
  return true;
}


int main() {
  Map *m = mapCreate(POINTER(str), NUMERIC(i32), null, MAP_EQL_STR_FUNC);

  str key = strCopy("Key000000");
  u32 key_len = strlen(key);
  u32 val = 0;

  while(increaseKey(key, key_len)) {
    mapInsert(m, strCopy(key), &val);
  }

  printf("Work done, map len is: %d\n", m->len);

  Iter *it = mapIter(m);

  while(it->ok) {
    DEALLOC(it->key);
    iterNext(it);
  }

  mapDestroy(m);
  DEALLOC(key);

  return 0;
}
