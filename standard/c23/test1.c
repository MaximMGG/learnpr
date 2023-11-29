#include <stdio.h>
#include <stdlib.h>
#include <string.h>



int main() {

    char a[20] = "Hello";

    char *b = malloc(sizeof(char) * 6);
    strcpy(b, "word");

    strcat(a, b);

    printf("%s\n", a);

    char *c = strdup(b);
    printf("%s\n", c);

    free(b);
    printf("%s\n", c);


    return 0;
}




