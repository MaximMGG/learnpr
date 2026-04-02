#include <stdio.h>
#include <stdlib.h>


void print_arr(int *arr, int len) {
    printf("[");
    for(int i = 0; i < len; i++) {
        printf("%d, ", arr[i]);
    }
    printf("]\n");
}


int main() {
    srand(5);
    int arr[6] = {5, 3, 1, 7, 1, 4};
    // for(int i = 0; i < 100; i++) {
    //     arr[i] = rand() % 100;
    // }

    int key = 0;
    int i = 0;
    for (int j = 1; j < 6; j++) {
        key = arr[j];

        i = j - 1;
        while (i > -1 && arr[i] > key) {
            arr[i + 1] = arr[i];
            i = i - 1;
            arr[i + 1] = key;
        }
    }

    print_arr(arr, 6);

    return 0;
}
