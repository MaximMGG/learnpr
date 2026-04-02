#include <stdio.h>


int main() {

    int a, b;
    a = 1;
    b = (a += 5) + (a *= 2);

    printf("%d\n", b);

    return 0;
}
