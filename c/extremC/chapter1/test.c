#include <setjmp.h>
#include <stdio.h>


char long_jump = 0;
jmp_buf buf;


void exit_m() {
    setjmp(buf);
    if (long_jump)
        printf("Long jump\n");
    else 
        printf("NOT Long jump\n");
}



int main() {

    int a = 2;
    int b = 3;
    exit_m();
    if (a - b < 0) {
        long_jump = 1;
        longjmp(&buf[0], 0);
        printf("i retern\n");
    }

    return 0;
}
