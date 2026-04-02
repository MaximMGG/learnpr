#include <stdio.h>
#include <stdlib.h>

#define SIZE 10000000

int main() {

    int *arr = malloc(sizeof(int) * (SIZE * 2));

    for(int i = 0; i < SIZE; i++) {
        arr[i] = i;
        arr[i + SIZE] = i;
    }

    for(int i = 0; i < SIZE; i++) {
        arr[i] = arr[i] + arr[i + SIZE];
    }

    printf("%d\n", arr[SIZE - 1]);
    free(arr);

    return 0;
}
