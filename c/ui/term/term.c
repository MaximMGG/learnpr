#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <pty.h>
#include <unistd.h>
#include <sys/select.h>
#include <cstdext/io/logger.h>


static int32_t masterfd;


size_t read_from_pty() {
    static char buf[SHRT_MAX];
    static u32 buflen = 0;

    i32 nbytes = read(masterfd, buf + buflen, sizeof(buf) - buflen);
    buflen += nbytes;
}

int main() {

    if (forkpty(&masterfd, null, null, null) == 0) {
        execlp("/usr/bin/bash", "bash", null);
        perror("execlp");
        exit(1);
    }

    bool running = true;

    fd_set fdset;

    while(running) {
        FD_ZERO(&fdset);
        FD_SET(masterfd, &fdset);

        select(masterfd + 1, &fdset, null, null, null);

        if (FD_ISSET(masterfd, &fdset)) {

        }
    }

    log(INFO, "Hello");
    return 0;
}
