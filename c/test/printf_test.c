#include <stdio.h>
#include <stdlib.h>


extern char **environ;

int main() {

    char *a = "Name";
    char *b = "Current expands";
    char *c = "Limit";
    char *d = "Difference";

    printf("%-30s %-30s %-30s %-30s\n", a, b, c, d);

    char *name = getenv("USER");
    printf("%s\n", name == NULL ? "NULL" : name);


    for(int i = 0; environ[i] != NULL; i++) {
        printf("%s\n", environ[i]);
    }


    return 0;
}
