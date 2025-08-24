#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>



int main() {

    void *mp = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    if (mp == MAP_FAILED) {
        perror("mmap error");
        exit(1);
    }

    int *x = mp;
    *x = 1;

    if (fork() == 0) {
        sleep(1);
        printf("Child: %d\n", *x);
        *x = 100;
    } else {
        printf("Parent: %d\n", *x);
        *x = 500;
        wait(NULL);
    }

    munmap(mp, sizeof(int));
    return 0;
}
