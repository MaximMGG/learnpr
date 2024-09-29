#include "arraylist.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <list>


int main() {

    char *msg = (char *)malloc(sizeof(char) * 20);
    strcpy(msg, "Bybgaga");


    arraylist<const char *> a = {};
    for(int i = 0; i < 5; i++) {
        a.add(msg);
    }


    for(int i = 0; i < 5; i++) {
        printf("index %d - %s\n", i, a.get(i));
    }
    printf("New list\n");

    std::list<const char *> l {};
    for(int i = 0; i < 5; i++) {
        l.push_back(msg);
    }

    free(msg);
    int j = 0;
    for(auto i = l.begin(); i != l.end(); i++, j++) {
        printf("index %d - %s\n", j, *i);
    }

    return 0;
}
