#include <string.h>
#include <stdio.h>



int main() {

  char *s = new char [1000241];
  memset(s, 'a', 1000240);
  s[1000240] = '\0';

  char *dest = new char [1000241];
  strcpy(dest, s);

  printf("Dest len is %ld\n", strlen(dest));

  delete []s;
  delete []dest;
}
