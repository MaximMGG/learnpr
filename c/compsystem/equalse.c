#include <stdio.h>

int equ(int x, int y) {
    return !(x ^ y) && 1;
}



int main() {

    int a = 777;
    int b = 888;
    int c = 77;
    int d = 777;

    printf("%x\n", equ(a, b));
    printf("%x\n", equ(a, b));
    printf("%x\n", equ(a, c));
    printf("%x\n", equ(a, d));


    return 0;
}
