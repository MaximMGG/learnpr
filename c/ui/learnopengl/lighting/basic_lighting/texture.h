#ifndef TEXTURE_H
#define TEXTURE_H
#include <glad/glad.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>


typedef struct {
  u32 id;
} Texture;

Texture textureLoadPng(str path);
Texture textureLoadJpg(str path);
void textureDestroy(Texture t);
void textureBind(Texture t);

#endif //TEXTURE_H
