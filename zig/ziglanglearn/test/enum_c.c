#include <stdio.h>
typedef enum {
    one, two, three
} enums;

void foo(enums e) {
    switch(e) {
        case one: 
            printf("One\n");
            break;
        case two:
            printf("Two\n");
            break;
        case three:
            printf("Three\n");
            break;
    }
}
