#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

typedef struct __attribute__((__packed__)){
    double r;
    double g;
    double b;
}Vec3;

typedef struct __attribute__((__packed__)){
    char buf[4096];
    int size;
    int cap;
    int fd;
} buf_writer;

buf_writer __attribute__((__always_inline__))buf_writer_init(int fd) {
    return (buf_writer){.buf = {0}, .cap = 4096, .size = 0, .fd = fd};
}

void __attribute__((__always_inline__))buf_writer_write(buf_writer *bw, void *data, int data_size) {
    if (bw->cap - bw->size <= data_size) {
        write(bw->fd, bw->buf, bw->size);
        memset(bw->buf, 0, bw->cap);
        bw->size = 0;
        memcpy(bw->buf, data, data_size);
        bw->size += data_size;
    } else {
        memcpy(&bw->buf[bw->size], data, data_size);
        bw->size += data_size;
    }
}

void buf_writer_flush(buf_writer *bw) {
    write(bw->fd, bw->buf, bw->size);
}

void __attribute__((__always_inline__)) write_color(buf_writer *bw, Vec3 vec) {
    int rb = (int)(255.999 * vec.r);
    int gb = (int)(255.999 * vec.g);
    int bb = (int)(255.999 * vec.b);

    char buf[512] = {0};
    sprintf(buf, "%d %d %d\n", rb, gb, bb);

    buf_writer_write(bw, buf, strlen(buf));
}

int main() {

    int width = 256;
    int height = 256;

    printf("P3\n%d %d\n255\n", width, height);
    buf_writer bw = buf_writer_init(STDOUT_FILENO);

    for(int j = 0; j < height; j++) {
        fprintf(stderr, "\rScanlines remaining: %d ", (height - j));
        for (int i = 0; i < width; i++) {

            Vec3 vec = {
                .r = ((double) i) / (width - 1),
                .g = ((double) j) / (height - 1),
                .b = 0.0
            };

            write_color(&bw, vec);
        }
    }

    buf_writer_flush(&bw);

    return 0;
}
