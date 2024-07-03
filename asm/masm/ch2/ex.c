#include <stdio.h>



int main() {

    int len = 256;
    int count = 0;
    char buf[256];
    char c;

    while((c = getc(stdin)) != '\n') {
        buf[count++] = c;
        if (count == len) break;
    }

    printf(buf);


    return 0;
}
