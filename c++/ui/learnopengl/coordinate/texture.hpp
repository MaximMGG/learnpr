#ifndef TEXTURE_HPP
#define TEXTURE_HPP
#include "render.hpp"
#include <iostream>
#define STB_IMAGE_IMPLEMENTATION
#include <stb/stb_image.h>

class Texture {
public:

    unsigned int ID;

    Texture(const char *path){
        GLCall(glGenTextures(1, &ID));
        GLCall(glBindTexture(GL_TEXTURE_2D, ID));
        GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT));
        GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT));

        GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR));
        GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR));

        int width, height, nrChannels;
        stbi_set_flip_vertically_on_load(true);
        unsigned char *data = stbi_load(path, &width, &height, &nrChannels, 0);
        if (data) {
            int format = (nrChannels == 4 ? GL_RGBA : GL_RGB);
            GLCall(glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data));
            GLCall(glGenerateMipmap(GL_TEXTURE_2D));
        } else {
            std::cerr << "Can't load texture\n";
            return;
        }
    }

    ~Texture() {
        GLCall(glDeleteTextures(1, &ID));
    }

    void bind() {
        GLCall(glBindTexture(GL_TEXTURE_2D, ID));
    }
    
    void unbind() {
        GLCall(glBindTexture(GL_TEXTURE_2D, 0));
    }

};


#endif //TEXTURE_HPP
