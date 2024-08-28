#include <pthread.h>
#include <cstdext/list.h>
#include <stdio.h>
#include <string.h>

struct m {
    list *l;
    int index;
};


//TODO (Maxim) list do not accept to multithreading
void *foo(void *l) {
    struct m *f = l;
    list *list = f->l;
    int index = f->index;
    char buf[16];
    memset(buf, 0, 16);

    int i = 250000 * index;

    for(int i = 0; i < 250000; i++) {
        if (i % 10 == 7 || i % 7 == 0) {
            listAdd(list, "SMAC", -1);
        } else {
            sprintf(buf, "%d", i);
            listAdd(list, buf, -1);
            memset(buf, 0, 16);
        }
    }
    return NULL;
}

void print_list(list *list) {
    for(int i = 0; i < list->len; i++) {
        printf("%s\n", (char *)listGet(list, i));
    }
}

int main() {
    list *list = newList(0, array_list, L_STRING);
    pthread_t w;
    pthread_create(&w, NULL, foo, list);
    pthread_join(w, NULL);

    print_list(list);

    listFree(list);
    return 0;
}
