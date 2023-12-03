#include <stdio.h>


int a = 12;
int b = 13;
int bsum;


int main(void) {
    printf("The global variables are %d and %d\n", a, b);

    __asm__(
            ".intel_syntax noprefix;"
            "mov    rax, a;"
            "add    rax, b;"
            "mov    bsum, rax;"
            :::"rax"
            );
    printf("The extended inline sum of global variables is %d.\n", bsum);
    int x = 14, y = 16, esum, eproduct, edif;
    printf("The local variables are %d and %d\n", x, y);

    __asm__(
            ".intel_syntax noprefix;"
            "mov    rax, rdx;"
            "add    rax, rcx;"
            :"=a"(esum)
            :"d"(x), "c"(y)
            );
    printf("The extended inline sum is %d.\n", esum);

    __asm__(
            ".intel_syntax noprefix;"
            "mov    rbx, rdx;"
            "imul   rbx, rcx;"
            "mov    rax, rbx;"
            :"=a"(eproduct)
            :"d"(x), "c"(y)
            :"rbx"
            );
    printf("The extended inline product is %d.\n", eproduct);



    __asm__(
            ".intel_syntax noprefix;"
            "mov    rax, rdx;"
            "sub    rax, rcx;"
            :"=a"(edif)
            :"d"(a), "c"(y)
            );
    printf("The extended inline asm difference is %d.\n", edif);
}
