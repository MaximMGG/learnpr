#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>



typedef struct {
    int id;
    char name[50];
    double value;
} Data;

int main() {

    const char *filename = "data.bin";

    int fd = open(filename, O_RDWR | O_CREAT, 0666);
    if (fd < 0) {
        perror("open");
        return 1;
    } 

    size_t dataSize = sizeof(Data) * 3;
    if (ftruncate(fd, dataSize) == -1) {
        perror("ftruncate");
        return 1;
    }

    Data *mapped = mmap(NULL, dataSize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mapped == MAP_FAILED) {
        perror("mmap");
        return 1;
    }


    Data data[3] = {{42, "Hello Bygagqag", 34.7}, 
                    {33, "Hello Proto", 234.134141}, 
                    {48, "Bye Huego", 0.1409123848519238}};

    memcpy(mapped, &data, dataSize);

    if (msync(mapped, dataSize, MS_SYNC) == -1) {
        perror("msync");
        exit(1);
    }

    munmap(mapped, dataSize);
    close(fd);
    return 0;
}
