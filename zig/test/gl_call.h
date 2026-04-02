//#include <stdio.h>


void first();
void second();
void middle();

#define GLCALL(x) \
    first();            \
    if (!x) {           \
        middle();   \
    }                   \
    second()               \
