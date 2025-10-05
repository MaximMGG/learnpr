#include <spng.h>
#include <stdio.h>
#include <stdlib.h>


int main() {
    FILE *f = fopen("Simple_cat.png", "rb");
    printf("Start\n");


    spng_ctx *ctx = spng_ctx_new(0);

    spng_set_crc_action(ctx, SPNG_CRC_USE, SPNG_CRC_USE);

    size_t limit = 1024 * 1024 * 64;
    spng_set_chunk_limits(ctx, limit, limit);

    spng_set_png_file(ctx, f);

    struct spng_ihdr ihdr;
    int res = spng_get_ihdr(ctx, &ihdr);
    if (res) {
        fprintf(stderr, "spng_get_ihdr() Error %s\n", spng_strerror(res));
        goto error;
    }

    struct spng_plte plte = {0};
    res = spng_get_plte(ctx, &plte);
    if (res && res != SPNG_ECHUNKAVAIL) {
        fprintf(stderr, "spng_get_plte() Error %s\n", spng_strerror(res));
        goto error;
    }

    size_t size, width;

    spng_decoded_image_size(ctx, SPNG_FMT_RGBA8, &size);
    printf("Image size: %ld\n", size);

    unsigned char *image = malloc(size);

    res = spng_decode_image(ctx, NULL, 0, SPNG_FMT_RGBA8, SPNG_DECODE_PROGRESSIVE);

    if (res) {
        fprintf(stderr, "spng_decode_image error: %s\n", spng_strerror(res));
        goto error;
    }

    size_t image_width = size / ihdr.height;

    struct spng_row_info row_info = {0};
        
    do {
        res = spng_get_row_info(ctx, &row_info);
        if (res) break;

        res = spng_decode_row(ctx, image + row_info.row_num * image_width, image_width);

    } while(res != SPNG_EOI);


    for(int i = 0; i < size; i += 4) {
        printf("[%d %d %d %d]\n", image[i], image[i + 1], image[i + 2], image[i + 3]);
    }

    free(image);

error:

    spng_ctx_free(ctx);

    printf("Finish\n");
    fclose(f);
    return 0;
}
