#include <stdio.h>
#include <time.h>
#include <sys/stat.h>
#include <stdlib.h>


void print_space(int repeat) {
    for(int i = 0; i < repeat; i++) {
        printf("%d - Hello world ", i);
    }
}

void print_new_line(int repeat) {
    for(int i = 0; i < repeat; i++) {
        printf("%d - Hello world\n", i);
    }
}




int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage <integer>");
        return 1;
    }

    int repeat = atoi(argv[1]);


    clock_t time_space = clock();
    print_space(repeat);
    time_space = clock() - time_space;
    double time_space_taken = (double)time_space / CLOCKS_PER_SEC;

    clock_t time_new_line = clock();
    print_new_line(repeat);
    time_new_line = clock() - time_new_line;
    double time_new_line_taken = (double)time_new_line / CLOCKS_PER_SEC;


    printf("Sapce time: \t%lf\nNew Line time: \t%lf\n", time_space_taken, time_new_line_taken);

    return 0;
}
