#include <cstdext/utils/sort.h>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>


int main() {
    srand(time(NULL));

    int arr[10000];
    for(i32 i = 0; i < 10000; i++) {
        arr[i] = rand();
    }

    util_fast_sort(arr, 10000, I32, null);

    for(i32 i = 0; i < 10000; i++) {
        printf("%d\n", arr[i]);
    }

    return 0;
}
