#include "texture.h"
#include <glad/glad.h>
#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>
#include <cstdext/core.h>

Texture textureCreatePng(str path) {
  if (!strEndsWith(path, ".png")) {
    fprintf(stderr, "textureCreatePng error, get not png file: %s\n", path);
    return 0;
  }
  Texture id;
  glGenTextures(1, &id);
  glBindTexture(GL_TEXTURE_2D, id);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  i32 width, height, nrChannels;
  stbi_set_flip_vertically_on_load(true);
  u8 *data = stbi_load(path, &width, &height, &nrChannels, 0);
  if (data) {
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
  } else {
    fprintf(stderr, "Can't load jpg image: %s\n", path);
    return 0;
  }
  stbi_image_free(data);

  return id;
}

Texture textureCreateJpg(str path) {
  if (!strEndsWith(path, ".jpg")) {
    fprintf(stderr, "textureCreateJpg error, get not jpg file: %s\n", path);
    return 0;
  }
  Texture id;
  glGenTextures(1, &id);
  glBindTexture(GL_TEXTURE_2D, id);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  i32 width, height, nrChannels;
  stbi_set_flip_vertically_on_load(true);
  u8 *data = stbi_load(path, &width, &height, &nrChannels, 0);
  if (data) {
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
  } else {
    fprintf(stderr, "Can't load jpg image: %s\n", path);
    return 0;
  }
  stbi_image_free(data);

  return id;
}

void textureDestroy(Texture t) {
  glDeleteTextures(1, &t);
}
