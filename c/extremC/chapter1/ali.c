#include <stdio.h>

void foo(int a, int b);

typedef struct {
    char a;
    char b;
    char c;
    short d;
} T;

typedef struct __attribute__((__packed__)){
    char a;
    char b;
    char c;
    short d;
} D;

typedef struct __attribute__((aligned(16))) {
    char a;
    char b;
    char c;
    short d;
} A;

int aali(int b) __attribute__((const));

int main() {

    T t = {.a = 'a', .b = 'b', .c = 'c', .d = 123};
    D d = {.a = 'a', .b = 'b', .c = 'c', .d = 123};
    A a = {.a = 'a', .b = 'b', .c = 'c', .d = 123};

    printf("%ld\n",sizeof(T));
    printf("%ld\n", sizeof(D));

    puts("");

    char *p = (char *)&t;
    for(int i = 0; i < sizeof(T); i++) {
        printf("%x\n", *(p++));
    }
    puts("");

    p = (char *) &d;

    for(int i = 0; i < sizeof(D); i++) {
        printf("%x\n", *(p++));
    }

    puts("");

    p = (char *) &a;
    for(int i = 0; i < sizeof(A); i++) {
        printf("%x\n", *(p++));
    }

    // int x __attribute__((aligned(16))) = 3;
    // printf("%ld\n", sizeof(x));
    
    foo(10, 20);

    int aa = aali(4);
    aa += 1;
    return 0;
}

void foo(int a, int b) {
    printf("%d\n", a + b);
}

int aali(int b) {

    return b + 1;
}
