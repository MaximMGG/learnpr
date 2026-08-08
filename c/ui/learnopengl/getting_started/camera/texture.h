#ifndef TEXTURE_H
#define TEXTURE_H
#include <glad/glad.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <stb_image.h>

typedef struct {
  u32 id;
} Texture;

Texture textureLoadPng(str path);
Texture textrueLoadJpg(str path);
void textureDestroy(Texture t);

#endif //TEXTURE_H
