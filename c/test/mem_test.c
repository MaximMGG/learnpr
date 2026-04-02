#include <stdio.h>
#include <stdlib.h>


int main() {

    int **arr = malloc(sizeof(int *) * 100000);

    getchar();
    printf("%p\n", arr);
    for(int i = 0; i < 100000; i++) {
        arr[i] = malloc(sizeof(int));
        *(arr[i]) = i;
    }

    getchar();
    printf("First %p\n", arr[0]);
    printf("Last %p\n", arr[99999]);
    for(int i = 0; i < 100000; i++) {
        free(arr[i]);
    }

    getchar();
    free(arr);

    return 0;
}
