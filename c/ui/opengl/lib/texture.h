#ifndef TEXTURE_H
#define TEXTURE_H
#include <GL/glew.h>
#include <stb/stb_image.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include "error.h"

u32 textureLoad(const char *path);
void textureBind(u32 texture);
void textureUnbind();
void textureDestroy(u32 *texture);

#endif //TEXTURE_H
