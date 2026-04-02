#include <stdio.h>
#include <unistd.h>
#ifndef __USE_POSIX
#define __USE_POSIX 1
#endif
#ifndef __USE_XOPEN_EXTENDED
#define __USE_XOPEN_EXTENDED
#endif
#include <signal.h>

void handler(int sig, siginfo_t *siginfo, void *context) {
    printf("Sending PID: %d, UID: %d\n", siginfo->si_pid, siginfo->si_uid);
}

int main() {
    fprintf(stderr, "pid: %i parent pid: %i\n", getpid(), getppid());

    struct sigaction sa = {0};
    sa.sa_sigaction = &handler;
    sa.sa_flags = SA_SIGINFO;

    sigaction(SIGINT, &sa, NULL);

    pause();

    return 0;
}
