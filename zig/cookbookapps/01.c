#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>


int readline(char *buf, int len, int fd) {
    int line_pos = 0;
    char tmp[len];
    memset(tmp, 0, len);

    int cur_seek = lseek(fd, 0, SEEK_CUR);
    read(fd, tmp, len);

    int newLine = 0;
    for(int i = 0; i < len; i++, newLine++) {
        if (tmp[i] == '\n') {
            break;
        }
    }
    cur_seek = lseek(fd, -(len - newLine - 1), SEEK_CUR);

    memcpy(buf, tmp, newLine + 1);
    return 0;
}



int main() {

    // FILE *f = fopen("tests/zig-zen.txt", "r");
    // if (!f)
    //     fprintf(stderr, "file not exist\n");

    int fd = open("tests/zig-zen.txt", O_RDONLY);
    int lines = 0;
    while(1) {
        char buf[264] = {0};
        // fgets(buf, 512, f);
        readline(buf, 264, fd);
        if (strlen(buf) != 0) {
            lines++;
            printf("%d -- %s", lines, buf);
        } else {
            break;
        }
    }

    return 0;
}
