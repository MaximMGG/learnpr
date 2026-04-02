#include <stdio.h>
#include "list.hpp"
#include "types.hpp"
#include <vector>

#define COUNT 10000000


int main() {
    printf("Begin list testing\n");

    List<int> t(COUNT);

    for(i32 i = 0; i < COUNT; i++) {
        t.append(i + 1);
    }


    printf("%d\n", t[4]);
    t[4] = 123123;
    printf("%d\n", t[4]);

    printf("%d\n", t[COUNT - 1]);
    t[COUNT - 1] = 999;
    printf("%d\n", t[COUNT - 1]);


    t << 3434;

    printf("%u\n", t.size());


    printf("End list testing\n");
    return 0;
}
