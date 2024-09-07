#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#define BUF_LEN 512

int main() {
    int fd = open("tests/zig-zen.txt", O_RDONLY);
    printf("FD is %d\n", fd);
    int seek = 0;
    seek = lseek(fd, 0, SEEK_CUR);
    printf("Seek before read %d\n", seek);

    char buf[BUF_LEN] = {0};
    read(fd, buf, 512);

    seek = lseek(fd, 0, SEEK_CUR);
    printf("Seek after read %d\n", seek);
    // seek = lseek(fd, -100, SEEK_CUR);
    // printf("Seek after lseek(-100) %d\n", seek);


    int newLine = 0;
    for(int i = 0; i < BUF_LEN; i++, newLine++) {
        if (buf[i] == '\n') {
            break;
        }
    }

    printf("New Line on %d\n", newLine);
    seek = lseek(fd, -(BUF_LEN - newLine - 1), SEEK_CUR);
    printf("Seek after newline %d\n", seek);

}
