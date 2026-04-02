#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

extern char **environ;


int main(int argc, char **argv) {
    int j;
    char **ep;

    clearenv();

    for(j = 0; j < argc; j++) {
        if (putenv(argv[j]) != 0) {
            fprintf(stderr, "putenv: %s\n", argv[j]);
            exit(1);
        }
    }
    if (setenv("GREET", "Hello, World!", 0) == -1) {
        fprintf(stderr, "setenv\n");
        exit(1);
    }
    unsetenv("BYE");
    for(ep = environ; *ep != NULL; ep++) {
        puts(*ep);
    }

    return 0;
}
