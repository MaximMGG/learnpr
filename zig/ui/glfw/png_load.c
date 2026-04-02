#include <spng.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>


static void show_error(const char *msg, ...) {
    va_list li;
    va_start(li, msg);
    vfprintf(stderr, msg, li);
    va_end(li);
}


unsigned char *load_png_rgba8_upside(const char *png_name, unsigned int *png_len, unsigned int *width, unsigned int *height) { 
    FILE *f = fopen(png_name, "rb");
    if (f == NULL) {
        show_error("Can't open file %s\n", png_name);
        return NULL;
    }
    int res;
    spng_ctx *ctx = spng_ctx_new(0);
    if (ctx == NULL) {
        show_error("spng_ctx_new() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    res = spng_set_crc_action(ctx, SPNG_CRC_USE, SPNG_CRC_USE);
    if (res != SPNG_OK) {
        show_error("spng_set_crc_action() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    res = spng_set_png_file(ctx, f);
    if (res != SPNG_OK) {
        show_error("spng_set_png_file() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    struct spng_ihdr ihdr;
    res = spng_get_ihdr(ctx, &ihdr);
    if (res != SPNG_OK) {
        show_error("spng_get_ihdr() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    size_t image_size = 0;
    res = spng_decoded_image_size(ctx, SPNG_FMT_RGBA8, &image_size);
    if (res != SPNG_OK) {
        show_error("spng_decoded_image_size() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }
    if (image_size == 0) {
        show_error("image_size is 0\n");
        spng_ctx_free(ctx);
        return NULL;
    }
    unsigned char *image = malloc(image_size);
    res = spng_decode_image(ctx, NULL, 0, SPNG_FMT_RGBA8, SPNG_DECODE_PROGRESSIVE);
    if (res != SPNG_OK) {
        show_error("spng_decode_image() error\n");
        spng_ctx_free(ctx);
        free(image);
        return NULL;
    }
    size_t image_width = image_size / ihdr.height;
    struct spng_row_info row_info;

    for(int i = ihdr.height - 1; i >= 0; i--) {
        void *row = image + image_width * i;

        res = spng_decode_row(ctx, row, image_width);
        if(res == SPNG_EOI) {
            break;
        }
    }
    // do {
    //     res = spng_get_row_info(ctx, &row_info);
    //     if (res != SPNG_OK) {
    //         show_error("spng_get_row_info() error\n");
    //         spng_ctx_free(ctx);
    //         free(image);
    //         return NULL;
    //     }
    //     res = spng_decode_row(ctx, image + image_width * row_info.row_num, image_width);
    // } while(res != SPNG_EOI);

    spng_ctx_free(ctx);
    fclose(f);

    *width = ihdr.width;
    *height = ihdr.height;
    *png_len = (unsigned int)image_size;
    return image;

}

unsigned char *load_png_rgba8(const char *png_name, unsigned int *png_len, unsigned int *width, unsigned int *height) {
    FILE *f = fopen(png_name, "rb");
    if (f == NULL) {
        show_error("Can't open file %s\n", png_name);
        return NULL;
    }
    int res;
    spng_ctx *ctx = spng_ctx_new(0);
    if (ctx == NULL) {
        show_error("spng_ctx_new() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    res = spng_set_crc_action(ctx, SPNG_CRC_USE, SPNG_CRC_USE);
    if (res != SPNG_OK) {
        show_error("spng_set_crc_action() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    res = spng_set_png_file(ctx, f);
    if (res != SPNG_OK) {
        show_error("spng_set_png_file() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    struct spng_ihdr ihdr;
    res = spng_get_ihdr(ctx, &ihdr);
    if (res != SPNG_OK) {
        show_error("spng_get_ihdr() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }

    size_t image_size = 0;
    res = spng_decoded_image_size(ctx, SPNG_FMT_RGBA8, &image_size);
    if (res != SPNG_OK) {
        show_error("spng_decoded_image_size() error\n");
        spng_ctx_free(ctx);
        return NULL;
    }
    if (image_size == 0) {
        show_error("image_size is 0\n");
        spng_ctx_free(ctx);
        return NULL;
    }
    unsigned char *image = malloc(image_size);
    res = spng_decode_image(ctx, NULL, 0, SPNG_FMT_RGBA8, SPNG_DECODE_PROGRESSIVE);
    if (res != SPNG_OK) {
        show_error("spng_decode_image() error\n");
        spng_ctx_free(ctx);
        free(image);
        return NULL;
    }
    size_t image_width = image_size / ihdr.height;
    struct spng_row_info row_info;
    do {
        res = spng_get_row_info(ctx, &row_info);
        if (res != SPNG_OK) {
            show_error("spng_get_row_info() error\n");
            spng_ctx_free(ctx);
            free(image);
            return NULL;
        }
        res = spng_decode_row(ctx, image + image_width * row_info.row_num, image_width);
    } while(res != SPNG_EOI);

    spng_ctx_free(ctx);
    fclose(f);

    *width = ihdr.width;
    *height = ihdr.height;
    *png_len = (unsigned int)image_size;
    return image;
}
