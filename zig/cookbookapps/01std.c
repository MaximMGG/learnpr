#include <stdio.h>


int main() {

    FILE *f = fopen("tests/zig-zen.txt", "r");
    char buf[264] = {0};
    int lines = 0;
    while(!feof(f)) {
        fgets(buf, 264, f);
        printf("%d - %s", lines, buf);
        lines++;
    }
    printf("Total lines %d\n", lines);


    return 0;
}
