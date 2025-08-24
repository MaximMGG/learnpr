#include <sys/mman.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main() {

    int size = sizeof(int *) * 10000;
    int **arr = malloc(size);


    for(int i = 0; i < 10000; i++) {
        arr[i] = malloc(sizeof(int));
        *(arr[i]) = i;
    }

    for(int i = 0; i < 10000; i++) {
        free(arr[i]);
    }

    free(arr);

    return 0;
}
