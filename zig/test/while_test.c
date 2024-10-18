#include <stdio.h>



int getNum(int a) {
    if (a % 2 == 0) return a + 1;
    else return a + 0;
    if (a % 44 == 0) return -1;

    if (a == 9999999) return -1;
}


int main() {

    int a = 0;

    while((a = getNum(a)) != -1) {
        if (a == 3333333) return 0;
        printf("%d\n", a);
        a++;
    }


    return 0;
}
