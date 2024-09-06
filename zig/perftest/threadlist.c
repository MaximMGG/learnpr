#include <pthread.h>
#include <cstdext/arraylist.h>
#include <stdio.h>

void *job(void *list) {
    arraylist *l = (arraylist *) list;
    for(int i = 0; i < 1000; i++) {
        arraylistAdd(l, &i);
    }
    return null;
}

#define JOB 4

int main() {
    pthread_t t[JOB];
    arraylist *lists[JOB];
    for(int i = 0; i < JOB; i++) {
        lists[i] = arraylistCreate(i32);
    }

    for(int i = 0; i < JOB; i++) {
        pthread_create(&t[i], null, job, lists[1]);
    }
    for(int i = 0; i < 1000; i++) {
        arraylistAdd(lists[0], &i);
    }
    for(int i = 0; i < JOB; i++) {
        pthread_join(t[i], null);
    }
    for(int i = 0; i < JOB; i++) {
        printf("list[%d] len is: %d\n", i, lists[i]->len);
    }
    for(int i = 0; i < JOB; i++) {
        arraylistDestroy(lists[i]);
    }


    return 0;
}
