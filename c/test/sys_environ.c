#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

extern char **environ;

int main() {

  for(int i = 0; environ[i] != NULL; i++) {
    printf("%s\n", environ[i]);
  }

  char *user_name = getenv("USERNAME");
  printf("User name: %s\n", user_name);
  return 0;
}
