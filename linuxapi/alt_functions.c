#include <fcntl.h>
#include <stdio.h>
#include "alt_functions.h"

#define BUF_SIZE 100

char *ALT_signal(int sig) {
    static char buf[BUF_SIZE];
    snprintf(buf, BUF_SIZE, "SIG-%d", sig);
    return buf;
}

char *ALT_hstrerror(int err) {
    static char buf[BUF_SIZE];
    snprintf(buf, BUF_SIZE, "hstrerrer-%d", err);
    return buf;
}

int ALT_posix_openpt(int flags) {
    return open("/dev/ptmx", flags);
}
