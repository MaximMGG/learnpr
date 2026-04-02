#include <stdio.h>



int main() {

    int a = 0x87654321;
    int mask1 = 0xFF;
    int mask2 = 0x123456FF;
    printf("%x\n", a & mask1);
    printf("%x\n", a & mask2);
    printf("%x\n", a | mask1);

    char c = 0xc3;
    printf("%d\n", c);
    printf("%d\n", c << 3);


    return 0;
}
