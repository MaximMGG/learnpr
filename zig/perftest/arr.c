#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char **arr = malloc(sizeof(char *) * 1000000);
    int i = 0;

    for(i = 0; i < 1000000; i++) {
        arr[i] = malloc(sizeof(char) * 2);
        strcpy(arr[i], "a");
    }
    printf("list len is: %d\n", i);

    for(int i = 0; i < 1000000; i++) {
        free(arr[i]);
    }
    free(arr);

    return 0;
}
