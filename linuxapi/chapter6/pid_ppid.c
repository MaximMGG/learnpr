#include <unistd.h>
#include <stdio.h>

int main() {

    pid_t my = getpid();
    pid_t my_p = getppid();

    printf("My pid - %d\n", my);
    printf("My parrent pid - %d\n", my);


    int n = fork();

    if (n == 0) {
        printf("This is parrent\n");
    } else {
        pid_t c = getpid();
        pid_t c_p = getppid();

        printf("Child pid %d\n", c);
        printf("Chile parrent pid %d\n", c_p);
    }

    printf("page size %ld\n", sysconf(_SC_PAGESIZE));
    return 0;
}
