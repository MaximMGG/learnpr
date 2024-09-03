#include <stdio.h>
#include <stdlib.h>
#include <time.h>


void print_arr(char *arr, int arr_size) {
    printf("{ ");
    for(int i = 0; i < arr_size; i++) {
        if (i < arr_size - 1) {
            printf("%d, ", arr[i]);
        } else {
            printf("%d ", arr[i]);
        }
    }
    printf("}\n");
}


int main() {
    srand(time(NULL));
    int rand_int = rand() % 5 + 5;
    char *arr = malloc(sizeof(char) * rand_int);

    for(int i = 0; i < rand_int; i++) {
        arr[i] = i;
    }
    print_arr(arr, rand_int);

    free(arr);

    return 0;
}
