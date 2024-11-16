#include <stdio.h>
#include "struc.h"


void Ext_func(Extern *e) {
    printf("Extern struct {a = %ud, b = %ld, c = %ud}\n", e->a, e->b, e->c);
}
