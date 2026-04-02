#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>


int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Expected filename\n");
        return 1;
    }

    char *filename = argv[1];

    int fd = open(filename, O_RDWR);
    if (fd == -1) {
        fprintf(stderr, "Can't open %s\n", filename);
        return 1;
    }

    struct stat st;
    if (fstat(fd, &st) == -1) {
        fprintf(stderr, "fstat error\n");
        return 1;
    }

    int input_size = st.st_size;

    void *mp = mmap(NULL, input_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mp == MAP_FAILED) {
        fprintf(stderr, "mmap fail\n");
        return 1;
    }

    char *data = mp;
    printf("File content:\n %s\n", data);

    for(int i = 0; i < st.st_size; i++) {
        data[i] = '1';
    }

    printf("File content:\n %s\n", data);

    if (munmap(mp, st.st_size) == -1) {
        fprintf(stderr, "munmap error\n");
    }
    if (close(fd) == -1) {
        fprintf(stderr, "close error\n");
        return 1;
    }

    return 0;
}

