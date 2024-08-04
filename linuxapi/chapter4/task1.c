#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


#define ERR(...) fprintf(stderr, __VA_ARGS__)
#define BUF_SIZE 1024


int main(int argc, char **argv) {

    int fd, offset;
    ssize_t readByte, writeByte;
    char buf[BUF_SIZE];

    if (argc > 1) {
        if (strcmp(argv[1], "--help") == 0) {
            ERR("Do not support --help");
        } 
    }

    if (strcmp(argv[1], "-a") == 0) {
        fd = open(argv[2], O_RDWR);
        if (fd == -1)
            ERR("cant open file %s\n", argv[1]);

        offset = lseek(fd, 0, SEEK_END);

        while((readByte = read(STDIN_FILENO, buf, BUF_SIZE)) != 0) {
            if (readByte == -1)
                ERR("Error read from STDIN\n");
            if (strncmp(buf, "q\n", readByte) == 0) {
                goto EXIT;
            }
            writeByte = write(fd, buf, readByte);

            if (writeByte == -1)
                ERR("Error append to file %s\n", argv[2]);
        }

    } else {
        fd = open(argv[1], O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR | S_IWGRP | S_IRGRP | S_IWOTH | S_IROTH);
        if (fd == -1) {
            ERR("cant create file %s\n", argv[1]);
        }
        while((readByte = read(STDIN_FILENO, buf, BUF_SIZE)) != 0) {
            if (readByte == -1)
                ERR("Error read from STDIN\n");
            if (strncmp(buf, "q\n", readByte) == 0)
                goto EXIT;
            writeByte = write(fd, buf, readByte);

            if (writeByte == -1)
                ERR("Error append to file %s\n", argv[2]);
        }

    }
EXIT:
    close(fd);

    return EXIT_SUCCESS;
}
