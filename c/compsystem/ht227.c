#include <stdio.h>


int uadd_ok(unsigned int a, unsigned int b) {
    unsigned int res = a + b;
    if (res > a && res > b) return 1;
    return 0;
}

int main() {
    unsigned int a = 0xffff9999;
    unsigned int b = 0x00004444;

    printf("%d\n", uadd_ok(a, b));

    return 0;
}
