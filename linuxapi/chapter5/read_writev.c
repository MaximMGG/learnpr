#include <sys/stat.h>
#include <fcntl.h>
#include <sys/uio.h>
#include <stdio.h>
#include <unistd.h>


typedef struct {
    int a;
    int b;
    float c;
    char *q;
} qqq;



int main() {

    qqq q = {.a = 7, .b = 6, .c = 3.3, .q = "Hello"};
    struct iovec io;

    int fd = open("q.txt", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
    if (fd == -1)
        fprintf(stderr, "Cant create file q.txt\n");

    io.iov_base = &q;
    io.iov_len = sizeof(q);

    size_t read_byte = 0;
    read_byte = writev(fd, &io, 1);
    if (read_byte != io.iov_len)
        fprintf(stderr, "write bytes - %ld, need %ld\n", read_byte, io.iov_len);

    close(fd);

    fd = open("q.txt", O_RDONLY);
    if (fd == -1)
        fprintf(stderr, "cant open file q.txt\n");

    qqq w;
    struct iovec need;
    need.iov_base = &w;
    need.iov_len = sizeof(qqq);

    read_byte = readv(fd, &need, 1);

    if (read_byte != need.iov_len)
        fprintf(stderr, "read bytes - %ld, need %ld\n", read_byte, io.iov_len);

    printf("%d %d %f %s\n", q.a, q.b, q.c, q.q);
    printf("%d %d %f %s\n", w.a, w.b, w.c, w.q);

    return 0;
}
