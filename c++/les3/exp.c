#include <stdio.h>
#include <pthread.h>

_Atomic int a;


void *foo(void *buf) {
    for(int i = 0; i < 1000000; i++) {
        a++;
    }
    return NULL;
}

int main() {

    pthread_t t;
    pthread_create(&t, NULL, foo, NULL);

    for(int i = 0; i < 1000000; i++) {
        a++;
    }

    pthread_join(t, NULL);

    printf("%d\n", a);
    return 0;
}
