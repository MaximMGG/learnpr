#include <stdio.h>


int main() {
    int a;
    int b;
    char c;

    char *fmt = "23,412i";

    sscanf(fmt, "%d,%d%c", &a, &b, &c);

    printf("%d - %d - %c\n", a, b, c);

    return 0;
}
