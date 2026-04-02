#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {

    char buf[1096] = {0};
    FILE *f = fopen("/proc/self/cmdline", "r");

    long bytes = fread(buf, 1, 1096, f);

    for(int i = 0; i < bytes; i++) {
        if (buf[i] == 0) {
            printf("\n");
        }
        printf("%c", buf[i]);
    }

    printf("\n");
    fclose(f);

    return 0;
}
