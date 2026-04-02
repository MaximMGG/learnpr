#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>


void sort_fast(int *arr, int arr_size) {
    if (arr_size == 1) {
        return;
    }
    if (arr_size > 2) {
        int l_arr_size = 0;
        int r_arr_size = 0;
        if (arr_size % 2 == 0) {
            // int l_arr[arr_size / 2];
            // int r_arr[arr_size / 2];

            int *l_arr = malloc(sizeof(int) * (arr_size / 2));
            int *r_arr = malloc(sizeof(int) * (arr_size / 2));

            memcpy(l_arr, arr, (arr_size / 2) * 4);
            memcpy(r_arr, arr + arr_size / 2, (arr_size / 2) * 4);
            sort_fast(l_arr, arr_size / 2);
            sort_fast(r_arr, arr_size / 2);
            l_arr_size = r_arr_size = arr_size / 2;
            // int fin_arr[arr_size];
            int *fin_arr = malloc(sizeof(int) * arr_size);
            int l_i = 0;
            int r_i = 0;
            for(int i = 0; i < arr_size; i++) {
                if (l_i == l_arr_size && r_i < r_arr_size) {
                    fin_arr[i] = r_arr[r_i++];
                    continue;
                } 
                if (r_i == r_arr_size && l_i < l_arr_size) {
                    fin_arr[i] = l_arr[l_i++];
                    continue;
                }
                if (l_arr[l_i] > r_arr[r_i]) {
                    fin_arr[i] = r_arr[r_i++];
                    continue;
                } else {
                    fin_arr[i] = l_arr[l_i++];
                    continue;
                }
            }
            memcpy(arr, fin_arr, arr_size * 4);
            free(l_arr);
            free(r_arr);
            free(fin_arr);
        } else {
            // int l_arr[arr_size / 2 + 1];
            // int r_arr[arr_size / 2];
            int *l_arr = malloc(sizeof(int) * (arr_size / 2 + 1));
            int *r_arr = malloc(sizeof(int) * (arr_size / 2));
            memcpy(l_arr, arr, (arr_size / 2 + 1) * 4);
            memcpy(r_arr, arr + arr_size / 2 + 1, (arr_size / 2) * 4);
            sort_fast(l_arr, arr_size / 2 + 1);
            sort_fast(r_arr, arr_size / 2);
            l_arr_size = arr_size / 2 + 1;
            r_arr_size = arr_size / 2;

            //int fin_arr[arr_size];
            int *fin_arr = malloc(sizeof(int) * arr_size);
            int l_i = 0;
            int r_i = 0;
            for(int i = 0; i < arr_size; i++) {
                if (l_i == l_arr_size && r_i < r_arr_size) {
                    fin_arr[i] = r_arr[r_i++];
                    continue;
                } 
                if (r_i == r_arr_size && l_i < l_arr_size) {
                    fin_arr[i] = l_arr[l_i++];
                    continue;
                }
                if (l_arr[l_i] > r_arr[r_i]) {
                    fin_arr[i] = r_arr[r_i++];
                    continue;
                } else {
                    fin_arr[i] = l_arr[l_i++];
                    continue;
                }
            }

            memcpy(arr, fin_arr, arr_size * 4);
            free(l_arr);
            free(r_arr);
            free(fin_arr);
        }
    } else if (arr_size == 2) {
        if (arr[0] > arr[1]) {
            int tmp = arr[0];
            arr[0] = arr[1];
            arr[1] = tmp;
            return;
        }
    }
}

#define count 1000000

int main() {
    srand(time(NULL));

    int arr[count] = {0};
    for(int i = 0; i < count; i++) {
        arr[i] = rand();
    }

    // for(int i = 0; i < count; i++) {
    //     printf("%d\n", arr[i]);
    // }

    // printf("========\n");
    printf("Start\n");
    sort_fast(arr, count);
    printf("End\n");
    //
    // for(int i = 0; i < count; i++) {
    //     printf("%d\n", arr[i]);
    // }

    return 0;
}
