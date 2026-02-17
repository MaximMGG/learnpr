#ifndef TEXTURE_HPP
#define TEXTURE_HPP

#include <GL/glew.h>
#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>
#include <string>
#include <iostream>

class Texture {

public:
  unsigned int id;

  Texture(std::string &path) {
    glCreateTextures(GL_TEXTURE_2D, 1, &this->id);
    glBindTexture(GL_TEXTURE_2D, this->id);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);


    stbi_set_flip_vertically_on_load(1);
    int width, height, nrChannels;
    unsigned char *buf = stbi_load(path.c_str(), &width, &height, &nrChannels, 0);
    if (buf) {
      int format = nrChannels == 4 ? GL_RGBA : GL_RGB;
      glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, buf);
      glGenerateMipmap(GL_TEXTURE_2D);
    } else {
      std::cerr << "stbi_load error\n";
      glDeleteTextures(1, &this->id);
      return;
    }
    stbi_image_free(buf);
  }

  void bind() {
    glBindTexture(GL_TEXTURE_2D, this->id);
  }

  void unbind() {
    glBindTexture(GL_TEXTURE_2D, 0);
  }

  ~Texture() {
    glDeleteTextures(1, &id);
  }
};

#endif
