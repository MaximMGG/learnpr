#include <string.h>
#include <stdlib.h>
#include <stdio.h>

char name[64];


// __attribute__((constructor))
// int beforemain() {
//     strcpy(name, "Julia");
//
//     return 0;
// }

[[noreturn]] void ex();

void func(char *a, void *b) __attribute__((nonnull(1)));

int main() {

    // printf("%s\n", name);

    printf("value is %s\n", NULL);
    func(NULL, NULL);
    ex();

    return 0;
}

void ex() {
    exit(0);
}

void func(char *a, void *b) {
    printf("func value is %s\n", a);
}

// __attribute__((destructor))
// int aftermain() {
//     memset(name, 0, 64);
//     printf("All done correct");
//     return 0;
// }
//
