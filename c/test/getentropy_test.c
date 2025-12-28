#include <stdio.h>
#include <unistd.h>


int main() {

  char buf[128] = {0};

  getentropy(buf, 128);
  printf("%s\n", buf);

  char *p = getpass("Enter password:");
  printf("User password: %s\n", p);

  return 0;
}
