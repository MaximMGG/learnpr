#include <stdio.h>

extern void asmFunc();

int main() {

    printf("Callong asmFunc...\n");
    asmFunc();
    printf("Retruned from asmFunc...\n");
    return 0;
}
