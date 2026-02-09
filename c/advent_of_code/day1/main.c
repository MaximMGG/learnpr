#include <cstdext/core.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>


List *readInput() {
  List *input = listFromFile(heap_allocator, "./input.txt", STR, 0);
  return input;
}

int main() {
  List *input = readInput();
  i32 res = 50;
  u32 pass = 0;

  for(u32 i = 0; i < input->len; i++) {
    str line = listGet(input, i);
    i32 prev_res = res;
    if (line[0] == 'L') {
      u32 num = atol(&line[1]); // 56
      res -= num;
      while (res < 0) {
        res += 100;
        if (prev_res == 0) continue;
        else pass += 1;
        if (res == 0) goto NEXT_ITER;
      }
    } else {
      u32 num = atol(&line[1]);
      res += num;
      while (res > 99) {
        res -= 100;
        if (prev_res == 0) continue;
        else pass += 1;
        if (res == 0) goto NEXT_ITER;
      }
    }
    if (res == 0) {
      pass += 1;
    }
NEXT_ITER:
  }

  printf("Res: %d\n", res);
  printf("Pass is: %d\n", pass);

  return 0;
}
