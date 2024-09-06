#include <stdio.h>
#include <cstdext/arraylist.h>
#include <cstdext/core.h>
#include <string.h>
#include <pthread.h>

#define JOBS 4

struct mem{
    arraylist *l;
    i32 index;
};

pthread_mutex_t mut;

void *job(void *l) {
    struct mem *m = (struct mem *) l;
    printf("list %p, index %d\n", m->l, m->index);
    pthread_mutex_lock(&mut);

    for(int i = m->index * 250000; i < m->index * 250000 + 250000; i++) {
        if (i % 7 == 0 || i % 10 == 7) {
            arraylistAdd(m->l, "SMAC");
        } else {
            char buf[32] = {0};
            sprintf(buf, "%d", i);
            arraylistAdd(m->l, buf);
        }
    }
    printf("List len is: %d\n", m->l->len);
    pthread_mutex_unlock(&mut);
    return null;
}

void print_list(arraylist *l) {
    for(int i = 0; i < l->len; i++) {
        printf("%s\n", (str) arraylistGet(l, i));
    }

}

int main() {
    pthread_t workers[JOBS];
    arraylist *lists[JOBS];
    pthread_mutex_init(&mut, null);
    for(int i = 0; i < JOBS; i++) {
        lists[i] = arraylistCreate(str);
    }
    for(int i = 0; i < JOBS; i++) {
        struct mem m = {.l = lists[i], .index = i};
        printf("before pthread call index = %d\n", m.index);
        pthread_create(&workers[i], null, job, &m);
    }
    for(int i = 0; i < JOBS; i++) {
        pthread_join(workers[i], null);
    }
    pthread_mutex_destroy(&mut);
    // for(int i = 0; i < JOBS; i++) {
    //     print_list(lists[i]);
    // }
    for(int i = 0; i < JOBS; i++) {
        printf("len of list %d is -> %d\n", i, lists[i]->len);
    }
    for(int i = 0; i < JOBS; i++) {
        arraylistDestroy(lists[i]);
    }

    return 0;
}
