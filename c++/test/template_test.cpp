#include <stdio.h>



template <typename T, typename D>
void assertEql(T a, D b, int line) {
  if (a != b) {
    printf("Not Eql %d line\n", line);
  } else {
    printf("Eql\n");
  }
}


int main() {


  assertEql(3, 3, __LINE__);

  return 0;
}
