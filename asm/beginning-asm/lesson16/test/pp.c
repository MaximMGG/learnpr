
#include <stdio.h>
extern int mult(int a); 




void printnum(int b) {
    printf("%d\n", b * 2);

    int cc = 22;
    printf("%d\n", mult(cc));
}
