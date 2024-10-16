#include <stdio.h>


int main() {
    int arr[100000] = {0};
    int num = 0;
    for(int i = 0; i < 100000; i++) {
        arr[i] = num;
        num++;
    }

    for(int i = 0; i < 100000; i++) {
        printf("%d\n", arr[i]);
    }

    return 0;
}
