#include "error_functions.h"
#include "tlpi_hdr.h"
#include <stdarg.h>


static void terminate(Boolean useExit3) {
    char *s;
    s = getenv("EF_DUMPCORE");
    if (s != NULL && *s != '\0') {
        abort();
    } else if (useExit3) {
        exit(EXIT_FAILURE);
    } else {
        _exit(EXIT_FAILURE);
    }
}

static void outputError(Boolean useErr, int err, Boolean flushStdout, const char *format, va_list ap) {
#define BUF_SIZE 500

    char buf[BUF_SIZE], userMsg[BUF_SIZE], errText[BUF_SIZE];
    vsnprintf(userMsg, BUF_SIZE, format, ap);

    if (useErr) {
        snprintf(errText, BUF_SIZE, "[%s %s]", (err > 0 && err <= MAX_ENAME))
    }

}
