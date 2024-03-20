#include "errort.h"
#include <stdio.h>
#include <string.h>
#include <setjmp.h>

typedef struct {
    char inside;
    jmp_buf jb;
}try_block;

try_block b;


#define TRY b.inside = 1;
#define CATCH(exeption)  \
            if (setjmp(b.jb)) {     \
                if ( _ ## exeption ## _t.active)    \

#define THROW(error, m) _ ## error ## _t.active = 1; if (m == NULL) {strcpy(_ ## error ## _t.msg, "error");} else {strcpy(_ ## error ## _t.msg, m);}  if (b.inside) longjmp(b.jb, 0);
#define E(exeption) _ ## exeption ## _t



void do_some() {
    int b = 2;
    int c = 3;

    if (b - c < 0) {
        THROW(my_error, "b - c < 0, not except in");
    }
}

int main() {
    TRY {
        do_some();
    } CATCH(my_error) {
        printf("%s\n", E(my_error).msg);
    }

    return 0;
}


