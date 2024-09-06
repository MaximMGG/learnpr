#include <stdio.h>
#include <cstdext/arraylist.h>
#include <cstdext/core.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>

#define JOBS 4

struct mem{
    arraylist *l;
    i32 index;
};

pthread_mutex_t mut;

void *job(void *l) {
    struct mem *m = (struct mem *) l;
    // printf("list %p, index %d\n", m->l, m->index);
    pthread_mutex_lock(&mut);

    for(int i = m->index * 2500000; i < m->index * 2500000 + 2500000; i++) {
        if (i % 7 == 0 || i % 10 == 7) {
            arraylistAdd(m->l, "SMAC");
        } else {
            char buf[32] = {0};
            sprintf(buf, "%d", i);
            arraylistAdd(m->l, buf);
        }
    }
    // printf("List len is: %d\n", m->l->len);
    pthread_mutex_unlock(&mut);
    return null;
}

void *print_list(void *l) {
    arraylist *list = (arraylist *) l;
    for(int i = 0; i < list->len; i++) {
        printf("%s\n", (str) arraylistGet(list, i));
    }

    return null;
}

int main() {
    pthread_t workers[JOBS];
    arraylist *lists[JOBS];
    struct mem *m[JOBS];
    pthread_mutex_init(&mut, null);
    for(int i = 0; i < JOBS; i++) {
        lists[i] = arraylistCreate(str);
    }
    for(int i = 0; i < JOBS; i++) {
        m[i] = new(struct mem);
        m[i]->index = i;
        m[i]->l = lists[i];
        // printf("before pthread call index = %d\n", m[i]->index);
        pthread_create(&workers[i], null, job, m[i]);
    }
    for(int i = 0; i < JOBS; i++) {
        pthread_join(workers[i], null);
    }
    pthread_mutex_destroy(&mut);
    for(int i = 0; i < JOBS; i++) {
        pthread_create(&workers[i], null, print_list, lists[i]);
        // print_list(lists[i]);
    }
    for(int i = 0; i < JOBS; i++) {
        pthread_join(workers[i], null);
    }
    for(int i = 0; i < JOBS; i++) {
        printf("len of list %d is -> %d\n", i, lists[i]->len);
    }
    for(int i = 0; i < JOBS; i++) {
        arraylistDestroy(lists[i]);
    }
    for(int i = 0; i < JOBS; i++) {
        free(m[i]);
    }

    return 0;
}

