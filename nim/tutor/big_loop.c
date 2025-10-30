#include <stdio.h>


#define SIZE 10000000

long process(long size) {
    long res = 0;
    for (long i = 0; i < size; i++) {
        res += 1;
    }
    return res;
}

int main() {

    printf("%ld\n", process(SIZE));

    return 0;
}
