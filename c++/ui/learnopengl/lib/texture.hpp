#ifndef TEXTURE_HPP
#define TEXTURE_HPP
#include <GL/glew.h>
#include <stb/stb_image.h>
#include "glcall.hpp"

class Texture {
public:
    unsigned int id;
    Texture(const char *path) {
        int width, height, nrChannels;
        stbi_set_flip_vertically_on_load(true);
        unsigned char *data = stbi_load(path, &width, &height, &nrChannels, 0);
        if (data) {
            GLCall(glGenTextures(1, &id));
            GLCall(glBindTexture(GL_TEXTURE_2D, id));
            GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT));
            GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT));

            GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR));
            GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR));

            int format = nrChannels == 4 ? GL_RGBA : GL_RGB;

            GLCall(glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data));
            GLCall(glGenerateMipmap(GL_TEXTURE_2D));
        }
        stbi_image_free(data);
    }

    ~Texture() {
        GLCall(glDeleteTextures(1, &id));
    }
    void bind() {
        GLCall(glBindTexture(GL_TEXTURE_2D, id));
    }

};

#endif //TEXTURE_HPP
