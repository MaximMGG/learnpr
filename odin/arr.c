#include <stdio.h>
#include <stdlib.h>


int *do_job(int size) {
    int *buf = malloc(sizeof(int) * size);

    for(int i = 0; i < size; i++) {
        buf[i] = i + 1;
    }
    return buf;
}

int main() {

    int *buf = do_job(10000000);

    printf("%d\n", buf[9999999]);

    free(buf);

    return 0;
}
