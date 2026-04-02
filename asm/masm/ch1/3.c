#include <stdio.h>

extern char *msgAsm();


int main(void) {

    printf("Calling msgAsm...\n");
    printf("%s\n", msgAsm());
    printf("After calling msgAsm...\n");

    return 0;
}
