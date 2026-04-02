#include <stdlib.h>
#include <stdio.h>



//iterate in any type, need that type has array with name data, and int size;
#define FORLOOP(type, in)  \
                for(type *it = in->data, j = 0; j < in->size; it++, j++)



typedef struct {
    int *data;
    unsigned int size;
}int_arr;


int main() {
    int_arr *t;
    t = (int_arr *) malloc(sizeof(int_arr));
    t->data = (int *) malloc(sizeof(int) * 5);
    t->size = 5;

    FORLOOP(int, t) {
        *it = j;
    }

    FORLOOP(int ,t) {
        printf("%d\n", *it);
    }
    //
    // for(int *it = t->arr, j = 0; j < t->size; it++, j++) {
    //     *it = j;
    // }
    //
    // for(int *it = t->arr, j = 0; j < t->size; it++, j++) {
    //     printf("%d\n", *it);
    // }


    return 0;
}
