#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>


int main() {

    void *start = sbrk(0);
    if (start == MAP_FAILED) {
        fprintf(stderr, "sbrk error\n");
    }
    printf("Prog start: %p", start);

    int *arr = sbrk(4096);

    for(int i = 0; i < 4096 / 4; i++) {
        arr[i] = i;
    }

    // for(int i = 0; i < 4096 / 4; i++) {
    //     printf("%d\n", arr[i]);
    // }

    brk(arr);

    return 0;
}
