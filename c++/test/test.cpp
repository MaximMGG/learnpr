#include "fast_sort.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main() {

    srand(time(NULL));

    int arr[10000];
    for(int i = 0; i < 10000; i++) {
        arr[i] = rand();
    }

    fast_sort<int>(arr, 10000);

    for(int i = 0; i < 10000; i++) {
        printf("%d\n", arr[i]);
    }

    return 0;
}
