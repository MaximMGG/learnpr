#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <unistd.h>
#include <time.h>


int main(int argc, char **argv) {

    int page = strtoll(argv[1], NULL, 0);
    int pagesize = getpagesize();
    printf("Page size: %d\n", pagesize);
    off_t offset = (off_t)page * pagesize;
    int fd = open(argv[1], O_RDWR);
    printf("fd: %d\n", fd);

    void *mp = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset);
    if (mp == MAP_FAILED) {
        perror("mmap error");
        exit(1);
    }
    printf("ptr: %p\n", mp);
    printf("pid: %d\n", getpid());
    int *data = mp;

    while(1) {
        printf("pid: %d, sec: %d, usec: %d\n", data[0], data[1], data[2]);
        struct timeval tt;
        gettimeofday(&tt, NULL);
        data[0] = getpid();
        data[1] = tt.tv_sec;
        data[2] = tt.tv_usec;
        sleep(1);
    }


    munmap(mp, pagesize);
    close(fd);
    return 0;
}
