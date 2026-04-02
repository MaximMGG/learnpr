#include <stdio.h>

char buf[256];

char *readLine(int buf_size) {
    char c;
    int count = 0;

    while((c = getc(stdin)) != '\n') {
        buf[count++] = c;
        if (buf_size == count) {
            break;
        }
    }
    return buf;
}

