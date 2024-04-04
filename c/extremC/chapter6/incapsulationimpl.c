#include "incapsulation.h"
#include <stdlib.h>


typedef struct {
    void *data;
    int size;
    int max_size;
} List;

list *l_create() {
    List *l = malloc(sizeof(List));

    l->data = malloc(sizeof(void *) * 10);
    l->size = 0;
    l->max_size = 10;

    return (list *) l;
}

int l_add(list *l) {
    List *n = (List *) l;

    n->size++;


    return 0;
}
