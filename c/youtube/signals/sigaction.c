#include <stdio.h>

#include <features.h>
#ifndef __USE_POSIX
#define __USE_POSIX 1
#endif
#ifndef __USE_XOPEN_EXTENDED
#define __USE_XOPEN_EXTENDED
#endif
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>


void handler(int n) {
    char msg[] = "got signal\n";
    write(STDOUT_FILENO, msg, sizeof(msg) - 1);
}


int main(int argc, char **argv) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s DELAY STRING\n", argv[0]);
        return 1;
    }

    struct sigaction sa = {};

    sa.sa_handler = handler;
    sa.sa_flags = SA_RESTART;

    sigaction(SIGINT, &sa, NULL);

    int delay = atoi(argv[1]);
    int counter = 1;

    while(true) {
        sleep(delay);
        printf("[%d] %d: %s\n", getpid(), counter++, argv[2]);

    }


    return 0;
}
