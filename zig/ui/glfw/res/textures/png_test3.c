#include <spng.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

char *get_png_buf(const char *file_name, int *buf_size) {
    int fd = open(file_name, O_RDONLY);
    if (fd < 0) {
        fprintf(stderr, "cant open file %s\n", file_name);
        exit(1);
    }

    struct stat st;
    fstat(fd, &st);

    char *buf = malloc(st.st_size);

    int read_bytes = read(fd, buf, st.st_size);
    if (read_bytes != st.st_size) {
        fprintf(stderr, "%ld - %d error read file\n", st.st_size, read_bytes);
        exit(1);
    }

    *buf_size = read_bytes;
    return buf;
}


int main() {
    int buf_size;
    char *buf = get_png_buf("Simple_cat.png", &buf_size);
    spng_ctx *ctx = spng_ctx_new(0);


    //FILE *file = fopen("Simple_cat.png", "rb");

    spng_set_png_buffer(ctx, buf, buf_size);
    //spng_set_png_file(ctx, file);
    spng_set_crc_action(ctx, SPNG_CRC_USE, SPNG_CRC_USE);


    //spng_decode_chunks(ctx);

    struct spng_ihdr ihdr;
    spng_get_ihdr(ctx, &ihdr);

    // struct spng_plte plte;
    // spng_get_plte(ctx, &plte);

    size_t image_size;
    spng_decoded_image_size(ctx, SPNG_FMT_RGBA8, &image_size);
    printf("Image size: %ld\n", image_size);


    unsigned char *image = malloc(image_size);
    spng_decode_image(ctx, NULL, 0, SPNG_FMT_RGBA8, SPNG_DECODE_PROGRESSIVE);

    int err;
    struct spng_row_info row_info;
    size_t image_width = image_size / ihdr.height;

    do {
        err = spng_get_row_info(ctx, &row_info);

        err = spng_decode_row(ctx, image + image_width * row_info.row_num, image_width);
    } while(err != SPNG_EOI);

    //
    // for(int i = 0; i < image_size; i += 4) {
    //     printf("[%d %d %d %d]\n", image[i], image[i + 1], image[i + 2], image[i + 3]);
    // }


    spng_ctx_free(ctx);
    free(buf);

    return 0;
}
