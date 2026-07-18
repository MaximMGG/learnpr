#include <string.h>
#include <stdio.h>


void __strcpy(char *dest, char *src) {
  int len = strlen(src);

  int big_cycles = len / 8;
  if (big_cycles < 1) {
    for(int i = 0; i < len; i++) {
      dest[i] = src[i];
    }
    dest[len] = '\0';
  }
  int small_cycles = len % 8;
  long *tmp_dest = (long *)dest;
  long *tmp_src = (long *)src;
  while((big_cycles--) > 0) *(tmp_dest++) = *(tmp_src++);
  
  if (small_cycles < 1) {
    dest[len] = '\0';
    return;
  } else {
    for(int i = (len / 8) * 8; i < len; i++) {
      dest[i] = src[i];
    }
    dest[len] = '\0';
  }
}


int main() {
  char *s = new char [1000241];
  memset(s, 'a', 1000240);
  s[1000240] = '\0';

  char *dest = new char [1000241];
  __strcpy(dest, s);

  printf("Dest len is %ld\n", strlen(dest));

  delete []s;
  delete []dest;

}
