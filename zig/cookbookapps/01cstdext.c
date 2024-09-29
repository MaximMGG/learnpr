#include <cstdext/stream.h>

int main() {
    str file = "test3.txt";
    stream *st = createStream(FILE_STREAM, file);

    str s;
    i32 count = 0;

    while((s = st->nextStr(st)) != null) {
        count++;
        printf("%d - %s\n", count, s);
    }
    printf("Total lines is: %d\n", count);
    destroyStream(st);

    return 0;
}
