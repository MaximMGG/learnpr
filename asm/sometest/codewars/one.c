#include <stdio.h>

extern char *greets(char *tmp);

int main() {

    char *name = "Bobby";

    printf("%s", greets(name));

    return 0;
}

