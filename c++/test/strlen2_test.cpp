#include <stdio.h>
#include <string.h>


int __strlen(char *str) {
  char *tmp = str;
  while(*(tmp++) != '\0');
  return tmp - str -1;
}


int main() {

  char *s = new char [100241];
  memset(s, 'a', 100240);
  s[100240] = '\0';

  int len = __strlen(s);
  printf("Len is %d\n", len);

  return 0;
}
