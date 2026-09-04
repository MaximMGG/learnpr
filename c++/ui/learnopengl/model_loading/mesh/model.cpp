#include "model.hpp"

u32 TextureFromFile(const char *path, const std::string &directory, bool gamme) {
  std::string filename = std::string(path);
  filename = directory + '/' + filename;

  u32 textureID;
  glGenTextures(1, &textureID);

  i32 width, height, nrComponents;

  u8 *data = stbi_load(filename.c_str(), &width, &height, &nrComponents, 0);
  if (data) {
    u32 format;
    if (nrComponents == 1) format = GL_RED;
    if (nrComponents == 3) format = GL_RGB;
    if (nrComponents == 4) format = GL_RGBA;

    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    stbi_image_free(data);
  } else {
    std::cout << "Texture load error: " << path << '\n';
    stbi_image_free(data);
  }

  return textureID;
}
