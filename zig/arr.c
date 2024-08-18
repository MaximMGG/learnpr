#include <stdio.h>


int main() {

    int arr[100000] = {0};
    int len = 0;
    for(int i = 0; i < 100000; i++) {
        arr[i] = 2 * 5 / 1 + 11 + 33 - 99;
        len++;
    }

    printf("Array len is: %d\n", len);

    return 0;
}
