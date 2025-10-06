#include <spng.h>
#include <GL/glew.h>
#include <cstdext/core.h>
#include "renderer.h"

typedef struct {
    u32 rendererID;
    const str file_name;
    u8 *local_buffer;
    u32 width;
    u32 height;
    u32 bpp;
    u32 slot;
} Texture;


unsigned char* load_png_rgba8(const char *file_name, u32 *image_size, u32 *width, u32 *heigth);
Texture TextureCreate(const str file_path);
void TextureDestroy(Texture *t);
void TextureBind(Texture *t, u32 slot);
void TextureUnbind(Texture *t);


