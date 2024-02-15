#include <iostream>

void mem_cpy(void *dest, void *source, unsigned long size) {
    char *p_d = (char *)dest;
    char *p_s = (char *) source;

    for (int i = 0; i < size; i++) {
        *(p_d)++ = *(p_s)++;
    }
}

struct app {
    int a;
    int b;
    long c;
    const char *name;
};

typedef struct pointer{} point;

int main() {

    point *p = new point[24];
    int a = 12;
    int b = 122;
    long z = 1111111;
    const char *name = "Egenu";
    mem_cpy(p, &a, 4);
    mem_cpy((p + 4), &b, 4);
    mem_cpy((p + 8), &z, 8);
    mem_cpy((p + 16), (void *)name, 8);
    
    struct app *ap = new struct app;
    ap->a = *(int *) p;
    ap->b = *(int *) (p + 4);
    ap->c  = *(long *) (p + 8);
    ap->name = (char *) (p + 16);

    std::cout << "a = " << ap->a << " b = " << ap->b << " z == " << ap->c << " name = " << ap->name << "\n";

    delete [] p;
    delete ap;
    return 0;
}
