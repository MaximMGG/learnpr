#include <stdlib.h>
#include <sys/mman.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>


int main(int argc, char **argv) {
    size_t size = 2ULL * 1024 * 1024 * 1024;

    char *ptr = malloc(size);

    getchar();

    if (argc > 1) {
        for(size_t i = 0; i < size; i++) {
            ptr[i] = '1';
        }
        printf("Success\n");
        getchar();
    }


    free(ptr);

    return 0;
}
