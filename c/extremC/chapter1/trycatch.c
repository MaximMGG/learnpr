#include "errort.h"
#include <stdio.h>
#include <string.h>



#define TRY 
#define CATCH(exeption)  \
            if ( _ ## exeption ## _t.active)

#define THROW(error, m) _ ## error ## _t.active = 1; if (m == NULL) {strcpy(_ ## error ## _t.msg, "error");} else strcpy(_ ## error ## _t.msg, m)
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


