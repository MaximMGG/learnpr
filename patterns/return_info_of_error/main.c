#include "reg_key.h"
#include <stdio.h>


int main() {

    RegKey my_key = createKey("MyKey");
    if (my_key == NULL) {
        printf("Error while reg creation");
    } 

    storeValue(my_key, "A");

    RegError err = publishKey(my_key);

    if(err == CANNOT_ADD_KEY) {
        printf("Can't publish reg");
    }

    return 0;
}
