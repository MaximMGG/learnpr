#include <stdio.h>






int main() {
    int a = 0x66;
    int b = 0x39;

    printf("%x\n", a & b);
    printf("%x\n", a | b);
    printf("%x\n", ~a | ~b);
    printf("%x\n", a & !b);
    printf("%x\n", a && b);
    printf("%x\n", a || b);
    printf("%x\n", ~a || ~b);
    printf("%x\n", a && !b);
    

    return 0;
}
