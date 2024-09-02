#include <stdio.h>


typedef struct {
    const char *name;
    int name_len;
}name;


void print_name(name *n) {
    printf("Name is : %s, name len is: %d\n", n->name, n->name_len);
}
