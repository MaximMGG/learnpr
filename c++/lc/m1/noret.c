#include <stdio.h>
#include <threads.h>
#include <pthread.h>

#define FOR(c) for(int i = 0 ; i < c; i++)

_Atomic int number = 0;

void *func(void *v) {
    FOR(100000) {
        number++;
    }


    return 0;
}


int main() {
    int r = 1;

    pthread_t t;
    pthread_create(&t, NULL, func, NULL);

    FOR(100000) {
        number++;
    }

    pthread_join(t, NULL);
    printf("%d\n", number);

    return 0;
}
