#include <string.h>
#include <stdio.h>


int main() {

  char *s = new char [100241];
  memset(s, 'a', 100240);
  s[100240] = '\0';

  int len = strlen(s);
  printf("Len is %d\n", len);

  return 0;
}
