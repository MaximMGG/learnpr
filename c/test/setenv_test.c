#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

extern char **environ;

int main() {

  setenv("MALLOC_TRACE", "/home/maxim/learnpr/linuxapi/chapter7/malloc_trace.txt", 1);

  for(int i = 0; environ[i] != NULL; i++) {
    printf("%s\n", environ[i]);
  }

  return 0;
}
