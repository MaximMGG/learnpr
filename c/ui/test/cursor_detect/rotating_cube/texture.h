#ifndef TEXTURE_H
#define TEXTURE_H
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <glad/glad.h>

typedef u32 Texture;

Texture textureLoadPng(str path);
Texture textureLoadJpg(str path);
void textureDestroy(Texture t);


#endif //TEXTURE_H



