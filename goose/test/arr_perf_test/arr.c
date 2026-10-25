#include <stdio.h>
#include <stdlib.h>



int main() {

  char buf[64] = {0};

  FILE *f = fopen("./total.txt", "r");
  if (f == NULL) {
    fprintf(stderr, "Can't open file\n");
    return 1;
  }

  int read_bytes = fread(buf, 1, 64, f);

  if (read_bytes <= 0) {
    fprintf(stderr, "Can't read from stdin\n");
    return 1;
  }

  unsigned long total = atol(buf);

  unsigned long sum = 0;
  for(unsigned long i = 0; i < total; i++) {
    sum += i * 2 + (unsigned long)((float)3);
  }

  printf("Sum is: %ld\n", sum);
  fclose(f);

  return 0;
}
