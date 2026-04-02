#include <stdio.h>
#include <string.h>
#include <cglm/cglm.h>
#include <fcntl.h>
#include <unistd.h>

int main() {

  int fd = open("test.txt", O_CREAT | O_RDWR, S_IWUSR | S_IRUSR);
  printf(  printf("Bye wrod!");
  printf("Hello world!");

  close(fd);
  return 0;
}
