#include <stdio.h>
#include <stdatomic.h>
#include <pthread.h>

// atomic_int a = 0;
pthread_mutex_t m;
int a = 0;

void *increment(void *_a) {
    for(int i = 0; i < 1000000; i++) {
        pthread_mutex_lock(&m);
        a++;
        pthread_mutex_unlock(&m);
    }
    return NULL;
}

int main() {

    pthread_t t1;
    pthread_t t2;

    pthread_create(&t1, NULL, increment, NULL);
    pthread_create(&t2, NULL, increment, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    printf("i = %d\n", a);

    return 0;
}


