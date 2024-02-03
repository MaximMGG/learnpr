#include <stdio.h>

extern int sum(int, int);

int main() {

    int a = sum(1, 2);
    printf("%i\n", a);
    return 0;
}


