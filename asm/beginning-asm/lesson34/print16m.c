#include <stdio.h>


const long mask = 8L;


int main() {

    long s, c = 64;
    
    while (c >= 0) {
        s = mask >> c--;
        if (s & 1) {
            printf("1");
        } else {
            printf("0");
        }
    }

    return 0;
}
