#include <stdio.h>



int calc(int count) {
    while(count--) {
        printf("a");
    }

    return 0;
}

int main() {
    calc(1000000);
    return 0;
}
