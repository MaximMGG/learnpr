#include <sys/mman.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main() {

    int size = sizeof(int *) * 10000;
    int **arr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);


    for(int i = 0; i < 10000; i++) {
        arr[i] = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        *(arr[i]) = i;
    }


    for(int i = 0; i < 10000; i++) {
        munmap(arr[i], sizeof(int));
    }

    munmap(arr, size);

    return 0;
}
