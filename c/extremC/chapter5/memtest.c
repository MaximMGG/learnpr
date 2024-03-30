#include <stdio.h>
#include <stdlib.h>


void print_mem_maps() {

    FILE *d = fopen("/proc/self/maps", "r");

    if (!d) {
        perror("Cant open file maps\n");
    }

    char line[1064];
    while(!feof(d)) {
        fgets(line, 1024, d);
        printf(" > %s\n", line);
    }

    fclose(d);
}



int main() {

    char *p1 = (char *) malloc(sizeof(char) * 10);
    printf("Address of p1: %p\n", (void *) &p1);
    printf("Memory allocated by malloc at %p: ", (void *) p1);

    for(int i = 0; i < 10; i++) {
        printf("0x%02x ", (unsigned char) p1[i]);
    }
    puts("");

    char *p2 = (char *) malloc(sizeof(char) * 10);
    printf("Address of p2: %p\n", (void *) &p2);
    printf("Memory allocated by malloc at %p: ", (void *) p2);

    for(int i = 0; i < 10; i++) {
        printf("0x%02x ", (unsigned char) p2[i]);
    }
    puts("");
    
    print_mem_maps();

    free(p1);
    free(p2);

    return 0;
}
