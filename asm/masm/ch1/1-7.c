#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void asmMain();
char *getTitle();

int readLine(char *dest, int maxLen) {
    char *result = fgets(dest, maxLen, stdin);
    if (result != NULL) {
        int len = strlen(result);
        if (len > 0) {
            dest[len - 1] = 0;
        }
        return len;
    }
    return -1;
}

int main() {

    char *title = getTitle();
    printf("Calling %s:\n", title);
    asmMain();
    printf("%s terminated\n", title);


    return 0;
}
