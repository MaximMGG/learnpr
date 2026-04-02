#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct app {
    int x;
    int y;
    long z;
    char *name;
};

typedef struct point point;

extern void mem_cpy_asm(void *dest, void *source, unsigned long size);


int main() {

    void *p = malloc(24);
    void *P = p;
    int x = 12;
    int y = 213421;
    long z = 1511111111111111;
    char *name = "Sham";
    mem_cpy_asm(P, &x, 4);
    mem_cpy_asm((P + 4), &y, 4);
    mem_cpy_asm((P + 8), &z, 8);
    mem_cpy_asm((P + 16), name, 8);
    struct app *a = malloc(sizeof(struct app));

    a->x = *(int *) P;
    a->y = *(int *) (P + 4);
    a->z = *(long *) (P + 8);
    a->name = (char *) (P + 16);

    printf("x = %d, y = %d, z = %ld, name = %s\n", a->x, a->y, a->z, a->name);

    free(p);
    free(a);

    return 0;
}
