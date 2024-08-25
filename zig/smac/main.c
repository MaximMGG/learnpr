#include <cstdext/list.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>

struct f {
    void *list;
    int id;
};

void *p_foo(void *s) {
    struct f *m = s;
    int id = m->id;
    list *l = m->list;
    int i = id * 250000;
    char buf[16] = {0};


    for( ; i < id * 250000 + 250000; i++) {
        if (i % 10 == 7 || i % 7 == 0) {
            listAdd(l, "SMAC", -1);
        } else {
            sprintf(buf, "%d", i);
            listAdd(l, buf, -1);
            memset(buf, 0, 16);
        }
    }
    return NULL;
}


void list_print(list *l) {
    for(int i = 0; i < l->len; i++) {
        printf("%s\n", (char *)listGet(l, i));
    }
}

int main() {
    int x = 4;
    list *list[x];
    pthread_t t[4];
    for(int i = 0; i < x; i++) {
        list[i] = newList(0, array_list, L_STRING);
    }
    for(int i = 0 ; i < x; i++) {
        struct f m = {list[i], i};
        pthread_create(&t[i], NULL, p_foo, &m);
    }

    for(int i = 0; i < x; i++) {
        pthread_join(t[i], NULL);
    }
    for(int i = 0; i < x; i++) {
        list_print(list[i]);
    }
    for(int i = 0; i < x; i++) {
        listFree(list[i]);
    }

    return 0;
}
