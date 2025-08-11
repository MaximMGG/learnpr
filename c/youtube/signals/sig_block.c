#include <stdio.h>
#include <unistd.h>
#ifndef __USE_POSIX
#define __USE_POSIX 1
#endif
#ifndef __USE_XOPEN_EXTENDED
#define __USE_XOPEN_EXTENDED
#endif
#include <signal.h>


void handler(int n) {
    const char msg[] = "Ctrl-C pressed\n";
    write(STDOUT_FILENO, msg, sizeof(msg) - 1);
}

int main() {

    struct sigaction sa = {0};
    sa.sa_handler = handler;
    sa.sa_flags = SA_NODEFER | SA_RESTART;
    sigaction(SIGINT, &sa, NULL);

    sigset_t mask;
    sigemptyset(&mask);
    sigaddset(&mask, SIGINT);
    sigaddset(&mask, SIGQUIT);


    while(1) {
        sigprocmask(SIG_BLOCK, &mask, NULL);

        printf("sleep started\n");
        sleep(10);
        printf("Sleep ended\n");

        sigprocmask(SIG_UNBLOCK, &mask, NULL);
    }

    return 0;
}
