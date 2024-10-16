#include <stdio.h>
#include <stdlib.h>

unsigned int getNum(unsigned int x) {
    if (x % 2 == 0) return x + 1;
    else return x;

}

int main() {
    int *arr = malloc(sizeof(int) * 3333333);
    for(int i = 0; i < 3333333; i++) {
        arr[i] = i;
    }
    for(int i = 0; i < 3333333; i++) {
        printf("%d\n", arr[i]);
    }
    free(arr);

    return 0;
}
