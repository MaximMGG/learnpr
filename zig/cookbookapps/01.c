#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>


int readline(char *buf, int len, int fd) {
    int read_bytes = read(fd, buf, len);

    int cur_seek = 0;
    int newLine = 0;
    int read_len = read_bytes <= len ? read_bytes : len;
    for(int i = 0; i < read_len; i++, newLine++) {
        if (buf[i] == '\n') {
            buf[i+1] = 0;
            break;
        }
    }
    if (read_bytes == 0 || read_len <= 1){
        return -1;
    };
    cur_seek = lseek(fd, -(read_len - newLine - 1), SEEK_CUR);

    return 0;
}



int main() {

    // FILE *f = fopen("tests/zig-zen.txt", "r");
    // if (!f)
    //     fprintf(stderr, "file not exist\n");

    // int fd = open("tests/zig-zen.txt", O_RDONLY);
    int fd = open("test2.txt", O_RDONLY);
    int lines = 0;
    char *buf = malloc(sizeof(char) * 128);
    while(1) {
        memset(buf, 0, 128);
        // fgets(buf, 512, f);
        // char buf[128] = {0};
        int res = readline(buf, 128, fd);
        if (res == -1)
            break;
        printf("%d - %s", lines, buf);
        lines++;
    }
    printf("Total lines %d\n", lines);

    free(buf);
    close(fd);
    return 0;
}
