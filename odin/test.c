#include <stdio.h>

unsigned int getNum(unsigned int x) {
    if (x % 2 == 0) return x + 1;
    else return x;

}

int main() {
    unsigned int x = 0;

    while (x < 3333333) {
        x = getNum(x);
        x++;
        printf("%d\n", x);
    }

    return 0;
}
