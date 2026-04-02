#include <stdio.h>

#define max_int 0x7fffffff
#define min_int 0xffffffff

int tadd_ok(int x, int y) {
    if (x < max_int / 2 && x > 0 && y < max_int / 2 && y > 0) {
        return 1;
    } else if (x < 0 && y > 0) {
        return 1;
    } else if (x > 0 && y < 0) {
        return 1;
    } else if (x > min_int / 2 && x < 0 && y > min_int / 2 && y < 0) {

    } else {
        return 0;
    }
    
    return 0;
}


int main() {

    int x = 1000000000;
    int y = 1000000000;

    printf("fisrt case x = %d, y = %d =  %d\n", x, y, tadd_ok(x, y));
    y = 2000000000;
    printf("second case x = %d, y = %d =  %d\n", x, y, tadd_ok(x, y));
    y = -2000000000;
    x = -2000000000;
    printf("therd case x = %d, y = %d =  %d\n", x, y, tadd_ok(x, y));
    y = 2100000000;
    printf("fours case x = %d, y = %d =  %d\n", x, y, tadd_ok(x, y));

    return 0;
}
