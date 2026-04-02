#include "Texture.h"
#include <stdio.h>
#include <cstdext/io/logger.h>


unsigned char* load_png_rgba8(const char *file_name, u32 *image_size, u32 *width, u32 *heigth) {
    FILE *png = fopen(file_name, "rb");
    if (png == null) {
        log(FATAL, "Can't open file %s", file_name);
        return null;
    }

    spng_ctx *ctx = spng_ctx_new(0);
    i32 res;
    res = spng_set_crc_action(ctx, SPNG_CRC_USE, SPNG_CRC_USE);
    if (res != SPNG_OK) {
        log(ERROR, "spng_set_crc_action() error");
        spng_ctx_free(ctx);
        fclose(png);
        return null;
    }
    res = spng_set_png_file(ctx, png);
    if (res != SPNG_OK) {
        log(ERROR, "spng_set_png_file() error");
        spng_ctx_free(ctx);
        fclose(png);
        return null;
    }
    struct spng_ihdr ihdr;
    res = spng_get_ihdr(ctx, &ihdr);
    if (res != SPNG_OK) {
        log(ERROR, "spng_get_ihdr() error");
        spng_ctx_free(ctx);
        fclose(png);
        return null;
    }
    size_t size;
    res = spng_decoded_image_size(ctx, SPNG_FMT_RGBA8, &size);
    if (res != SPNG_OK) {
        log(ERROR, "spng_decoded_image_size() error");
        spng_ctx_free(ctx);
        fclose(png);
        return null;
    }
    u8 *image = malloc(size);
    res = spng_decode_image(ctx, null, 0, SPNG_FMT_RGBA8, SPNG_DECODE_PROGRESSIVE);
    if (res != SPNG_OK) {
        log(ERROR, "spng_decode_image() error");
        spng_ctx_free(ctx);
        fclose(png);
        free(image);
        return null;
    }


    size_t image_width = size / ihdr.height;
    struct spng_row_info row_info;
    for(i32 i = ihdr.height - 1; i >= 0; i--) {
        res = spng_get_row_info(ctx, &row_info);
        if (res != SPNG_OK) {
            log(ERROR, "spng_get_row_info() error");
            spng_ctx_free(ctx);
            fclose(png);
            free(image);
            return null;
        }
        res = spng_decode_row(ctx, image + image_width * i, image_width);
    }


    // size_t image_width = size / ihdr.height;
    // struct spng_row_info row_info;
    // do {
    //     res = spng_get_row_info(ctx, &row_info);
    //     if (res != SPNG_OK) {
    //         log(ERROR, "spng_get_row_info() error");
    //         spng_ctx_free(ctx);
    //         fclose(png);
    //         free(image);
    //         return null;
    //     }
    //     res = spng_decode_row(ctx, image + image_width * row_info.row_num, image_width);
    // } while(res != SPNG_EOI);

    spng_ctx_free(ctx);
    *image_size = size;
    *width = ihdr.width;
    *heigth = ihdr.height;
    return image;
}

Texture TextureCreate(const str file_path) {
    Texture t = {};
    u32 image_size;
    t.local_buffer = load_png_rgba8(file_path, &image_size, &t.width, &t.height);
    if (t.local_buffer == null) {
        log(FATAL, "Cant load image: %s", file_path);
        return t;
    }
    GLCall(glGenTextures(1, &t.rendererID));
    GLCall(glBindTexture(GL_TEXTURE_2D, t.rendererID));

    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR));
    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR));
    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE));
    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE));

    GLCall(glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, t.width, t.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, t.local_buffer));
    GLCall(glBindTexture(GL_TEXTURE_2D, 0));

    return t;
}

void TextureDestroy(Texture *t) {
    free(t->local_buffer);
    GLCall(glDeleteTextures(1, &t->rendererID));

}

void TextureBind(Texture *t, u32 slot) {
    GLCall(glActiveTexture(GL_TEXTURE0));
    GLCall(glBindTexture(GL_TEXTURE_2D, t->rendererID));
    t->slot = slot;
}

void TextureUnbind(Texture *t) {
    glBindTexture(GL_TEXTURE_2D, 0);
}
