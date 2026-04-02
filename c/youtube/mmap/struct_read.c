#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>


typedef struct {
    int id;
    char name[50];
    double value;
} Data;


int main() {

    const char *filename = "data.bin";
    int fd = open(filename, O_RDWR);
    struct stat st;

    if (fstat(fd, &st) == -1) {
        perror("fstat");
        exit(1);
    }

    if (st.st_size == 0) {
        perror("File size is 0");
        exit(1);
    }

    int struct_count = st.st_size / sizeof(Data);

    Data *datas = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

    for(int i = 0; i < struct_count; i++) {
        printf("%d - {\n%d\n%s\n%lf\n}\n", i, datas[i].id, datas[i].name, datas[i].value);
    }

    msync(datas, st.st_size, MS_SYNC);
    munmap(datas, st.st_size);
    close(fd);
    return 0;
}

