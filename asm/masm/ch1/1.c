#include <stdio.h>

extern void asmFunc(void);

int main() {

    printf("Colling asmFunc...\n");
    asmFunc();
    printf("Retruning from asmFunc...\n");

    return 0;
}
