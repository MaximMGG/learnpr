#include <stdio.h>
#include <threads.h>

#define FOR(c) for(int i = 0 ; i < c; i++)

_Atomic int number = 0;

int func(void *v) {
    FOR(100000) {
        number++;
    }


    return 0;
}


int main() {
    int r = 1;
    thrd_t t1;
    thrd_create(&t1, &func, NULL);

    FOR(100000) {
        number++;
    }
    thrd_join(t1, &r);
    printf("%d\n", number);

    return 0;
}
