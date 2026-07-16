#include "texture.h"
#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>


Texture textureLoadPng(str path) {

  Texture t;
  glGenTextures(1, &t);
  glBindTexture(GL_TEXTURE_2D, t);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  i32 width, height, nrChannels;
  stbi_set_flip_vertically_on_load(true);
  u8 *data = stbi_load(path, &width, &height, &nrChannels, null);
  if (!data) {
    log(ERROR, "stbi_load return null");
    glDeleteTextures(1, &t);
    return 0;
  } else {
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
  }

  return t;
}

Texture textureLoadJpg(str path) {
  Texture t;
  glGenTextures(1, &t);
  glBindTexture(GL_TEXTURE_2D, t);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  i32 width, height, nrChannels;
  stbi_set_flip_vertically_on_load(true);
  u8 *data = stbi_load(path, &width, &height, &nrChannels, null);
  if (!data) {
    log(ERROR, "stbi_load return null");
    glDeleteTextures(1, &t);
    return 0;
  } else {
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
  }

  return t;

}
void textureDestroy(Texture t);
