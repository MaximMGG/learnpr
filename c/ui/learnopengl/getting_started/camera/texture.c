#include "texture.h"

Texture textureLoadPng(str path) {
  if (!strEndsWith(path, ".png")) {
    LOG(ERROR, "textureLoadPng, but get not .png file as input: %s", path);
    return (Texture){.id = 0};
  }

  u32 t;
  glGenTextures(1, &t);
  glBindTexture(GL_TEXTURE_2D, t);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  stbi_set_flip_vertically_on_load(true);
  i32 width, height, nrChannels;
  u8 *data = stbi_load(path, &width, &height, &nrChannels, 0);
  if (data) {
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);

  } else {
    LOG(ERROR, "stbi_load failed");
    return (Texture){.id = 0};
  }
  stbi_image_free(data);

  return (Texture){.id = t};
}

Texture textrueLoadJpg(str path) {
  if (!strEndsWith(path, ".jpg")) {
    LOG(ERROR, "textureLoadJpg, but get not .jpg file as input: %s", path);
    return (Texture){.id = 0};
  }

  u32 t;
  glGenTextures(1, &t);
  glBindTexture(GL_TEXTURE_2D, t);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  stbi_set_flip_vertically_on_load(true);
  i32 width, height, nrChannels;
  u8 *data = stbi_load(path, &width, &height, &nrChannels, 0);
  if (data) {
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);

  } else {
    LOG(ERROR, "stbi_load failed");
    return (Texture){.id = 0};
  }
  stbi_image_free(data);

  return (Texture){.id = t};

}

void textureDestroy(Texture t) {
  glDeleteTextures(1, &t.id);
}
