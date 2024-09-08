#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

#define READ_BUF (4096)

char readbuf[READ_BUF] = {0};
int offset = 0;

int readline(char *buf, int len, int fd) {

    int read_bytes = 0;
    if (offset == READ_BUF || offset == 0) {
        read_bytes = read(fd, readbuf, READ_BUF);
        offset = 0;
    }
    int i = 0;
    int start_offset = offset;
    for( ; i < len && offset < READ_BUF; i++, offset++) {
        if (readbuf[offset] == '\n') {
            memcpy(buf, &readbuf[start_offset], i + 1);
            offset++;
            return 0;
        }
    }
    memcpy(buf, &readbuf[start_offset], i);
    memset(readbuf, 0, READ_BUF);
    read_bytes = read(fd, readbuf, READ_BUF);
    if (read_bytes == 0) {
        return -1;
    }
    offset = 0;
    int j = 0;
    start_offset = offset;
    for( ; i + j < len && offset < READ_BUF; j++, offset++) {
        if (readbuf[offset] == '\n') {
            memcpy(&buf[i], &readbuf[start_offset], j + 1);
            offset++;
            return 0;
        }
    }
    memcpy(&buf[i], &readbuf[start_offset], j);

    return 0;
}



int main() {

    // int fd = open("tests/zig-zen.txt", O_RDONLY);
    int fd = open("test2.txt", O_RDONLY);

    char buf[128] = {0};
    int res = 0;
    int lines = 0;
    while(1) {
        memset(buf, 0, 128);
        res = readline(buf, 128, fd);
        if (res == -1) {
            break;
        }
        lines++;
        printf("%d - %s", lines, buf);
    }

    printf("Total line %d\n", lines);
    close(fd);
    return 0;
}
