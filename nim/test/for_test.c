#include <stdio.h>
#include <limits.h>


int main() {
  unsigned long sum = 0;

  for(int i = INT_MIN; i < INT_MAX; i++) {
    sum += i;
  }

  printf("Sum is: %lu\n", sum);

  return 0;
}
