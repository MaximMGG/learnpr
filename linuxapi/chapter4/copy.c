#include <sys/stat.h>
#include <fcntl.h>
#include "../tlpi_hdr.h"

#ifndef BUF_SIZE
#define BUF_SIZE 1024
#endif

int main(int argc, char **argv) {
    
    int inputFd, outputFd, openFlags;
    mode_t filePerms;
    ssize_t numRead;
    char buf[BUF_SIZE] = {0};

    if (argc != 3 || strcmp(argv[1], "--help") == 0) {
        usageErr("%s old-file new-file\n", argv[0]);
    }
    inputFd = open(argv[1], O_RDONLY);
    if (inputFd == -1) {
        errExit("opening file %s\n", argv[1]);
    }
    openFlags = O_CREAT | O_WRONLY | O_TRUNC;
    filePerms = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH; // rw-rw-rw

    outputFd = open(argv[2], openFlags, filePerms);
    if (outputFd == -1)
        errExit("opening file %s\n", argv[2]);

    while((numRead = read(inputFd, buf, BUF_SIZE)) > 0)
        if (write(outputFd, buf, numRead) != numRead)
            fatal("could't write whole buffer\n");
    if (numRead == -1)
        errExit("read");
    if (close(inputFd) == -1)
        errExit("close input\n");
    if (close(outputFd) == -1)
        errExit("close output\n");

    return EXIT_SUCCESS;
}
