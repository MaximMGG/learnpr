#include <cstdext/core.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>


List *readInput() {
  List *input = listFromFile(heap_allocator, "./test_input.txt", STR, 0);
  return input;
}

int main() {
  List *input = readInput();
  i32 res = 50;
  u32 pass = 0;

  for(u32 i = 0; i < input->len; i++) {
    str line = listGet(input, i);
    if (line[0] == 'L') {
      u32 num = atol(&line[1]); // 56
      res -= num;
      while (res < 0) {
        res += 100;
        pass += 1;
      }
    } else {
      u32 num = atol(&line[1]);
      res += num;
      while (res > 99) {
        res -= 100;
        pass += 1;
      }
    }
    if (res == 0) {
      pass += 1;
    }
  }

  printf("Res: %d\n", res);
  printf("Pass is: %d\n", pass);

  return 0;
}
