#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>




int main() {

    const char *msg = "Hello";
    close(STDOUT_FILENO);
    fprintf(stdout, "%s\n", msg);

    int fdout = open("/dev/tty", O_RDWR);
    if (fdout != -1)
        write(fdout, msg, 6);
    write(fdout, "\n", 2);

    close(fdout);

    return 0;
}
