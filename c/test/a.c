#include <fcntl.h>
#include <stdio.h>
#include <fcntl.h>
#include <cstdext/core.h>
#include <cstdext/io/writer.h>
#include <unistd.h>


int main() {
    printf("%d\n", (int)1 << 13);
    printf("%s\n", "Hello");

    i32 fd = open("Test.txt", O_CREAT | O_RDWR, 0666);

    writer *w = writer_create(fd, null, 0);

    writer_write(w, "OIJOIJOIJ");
    writer_destroy(w);

    read(fd, null, 10);

    close(fd);

    return 0;
}
