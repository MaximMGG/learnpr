#include <sys/stat.h>
#include <sys/uio.h>
#include <fcntl.h>
#include "../tlpi_hdr.h"

int main(int argc, char **argv) {

    int fd;
    struct iovec iov[3];
    struct stat muStruct;
    int x;
#define STR_SIZE 100
    char str[STR_SIZE];

    ssize_t numRead, totRequired;
    if (argc != 2 || strcmp(argv[1], "--help") == 0) {
        usageErr("%s file\n", argv[0]);
    }
    fd = open(argv[1], O_RDONLY);
    if (fd == -1)
        errExit("open");
    totRequired = 0;
    iov[0].iov_base = &muStruct;
    iov[0].iov_len = sizeof(muStruct);
    iov[1].iov_base = &x;
    iov[1].iov_len = sizeof(x);
    iov[2].iov_base = str;
    iov[2].iov_len = STR_SIZE;
    totRequired += iov[0].iov_len + iov[1].iov_len + iov[2].iov_len;
    numRead = readv(fd, iov, 3);

    if (numRead == -1)
        errExit("readv");
    if (numRead < totRequired)
        printf("Read fewer bytes then requested\n");

    printf("total bytes requested: %ld; bytes read: %ld\n", numRead, totRequired);

    exit(EXIT_SUCCESS);
    return 0;
}
