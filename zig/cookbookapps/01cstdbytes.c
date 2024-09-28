#include <cstdext/stream.h>


int main() {

    str file = "test2.txt";
    stream *st = createStream(FILE_STREAM, file);

    i8 b;
    i32 count = 0;
    i8 buf[128] = {0};
    i32 i = 0;
    while((b = st->nextByte(st)) != 0) {
        buf[i++] = b;
        if (b == '\n') {
            printf("%d - %s", count, buf);
            count++;
            memset(buf, 0, 128);
            i = 0;
        }
    }
    printf("%d - %s\n", count, buf);

    printf("Total lines is: %d\n", count);
    destroyStream(st);

    return 0;
}
