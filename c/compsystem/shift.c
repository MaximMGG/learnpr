#include <stdio.h>

int fun1(unsigned int i) {
    return (int) ((i << 24) >> 24);
}

int fun2(unsigned int i) {
    return ((int) i << 24) >> 24;
}


int main() {

    unsigned int a = 0x00000076;
    unsigned int b = 0x87654321;
    unsigned int c = 0x000000C9;
    unsigned int d = 0xEDCBA987;

    printf("%x\n", fun1(a));
    printf("%x\n", fun2(a));
    printf("%x\n", fun1(b));
    printf("%x\n", fun2(b));
    printf("%x\n", fun1(c));
    printf("%x\n", fun2(c));
    printf("%x\n", fun1(d));
    printf("%x\n", fun2(d));


    return 0;
}
