#include <stdio.h>
#include <string.h>


int main() {
  char *a = "helLo";
  char *b = "hello";

  printf("%d\n", strcasecmp(a, b));

  return 0;
}
