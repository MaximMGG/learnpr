#ifndef TEXTURE_H
#define TEXTURE_H
#include <cstdext/core.h>

typedef u32 Texture;

Texture textureCreatePng(str path);
Texture textureCreateJpg(str path);
void textureDestroy(Texture t);


#endif //TEXTURE_H

