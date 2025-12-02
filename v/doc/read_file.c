#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  FILE *f = fopen("basic.v", "r");
  if (f == NULL) {
    return 1;
  }
  char buf[4096] = {0};

  int iteration = 50;
  unsigned long total = 0;
  while(iteration > 0) {
    unsigned long read_bytes = fread(buf, 1, 4096, f);
    total += read_bytes;
    printf("Read %lu bytes\n %s\n", read_bytes, buf);
    iteration--;
    memset(buf, 0, 4096);
    fseek(f, 0, SEEK_SET);
  }

  fclose(f);

  printf("Total read: %lu bytes\n", total);

  return 0;
}

