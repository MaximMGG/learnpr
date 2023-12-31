#include "reg_key.h"
#include <stdio.h>


int main() {
    RegError err;
    RegKey my_key;

    err = createKey(&my_key, "my_key");
    if (err == INVALID_KEY || err == INVALID_STRING) {
        printf("App exeption");
    }
    if (err == STRING_TOO_LONG) {
        printf("Lengs of register too long");
    }
    if (err == OUT_OF_MEMORY) {
        printf("Do not have anaph memory fo register creating");
    }

    err = storeValue(my_key, "A");
    if (err == INVALID_KEY || err == INVALID_STRING) {
        printf("App exeption");
    }
    if (err == STRING_TOO_LONG) {
        printf("Lengs of register too long");
    }
    err = publishKey(my_key);
    if (err == INVALID_KEY || err == INVALID_STRING) {
        printf("App exeption");
    }
    if (err == CANNOT_ADD_KEY) {
        printf("Cannot pablish a regs");
    }



    return 0;
}
