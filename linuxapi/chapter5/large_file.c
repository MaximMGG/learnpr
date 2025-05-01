#define _LARGEFILE64_SOURCE
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>



int main(int argc, char **argv) {

    if (argc != 3) {
        fprintf(stderr, "Usage: ./large_file [mult] [SIZE]");
        return -1;
    }

    int fd;
    off64_t off;

    fd = open64(argv[1], O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
    if (fd == -1) {
        fprintf(stderr, "Cant create file\n");
        return -1;
    }
    off = atoll(argv[2]);

    if (lseek64(fd, off, SEEK_SET) == -1) {
        fprintf(stderr, "Error lseek64\n");
        close(fd);
        return -1;
    }

    if (write(fd, "test", 4) == -1) {
        fprintf(stderr, "Error write\n");
        close(fd);
        return -1;
    }

    close(fd);
    return 0;
}
