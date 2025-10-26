#ifndef TEXTURE_HPP
#define TEXTURE_HPP
#include "render.hpp"
#include <iostream>

class Texture {
public:

    unsigned int ID;

    Texture(const char *path){
        glGenTextures(1, &ID);
        glBindTexture(GL_TEXTURE_2D, ID);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

        int width, height, nrChannels;
        stbi_set_flip_vertically_on_load(true);
        unsigned char *data = stbi_load(path, &width, &height, &nrChannels, 0);
        if (data) {
            int format = nrChannels == 4 ? GL_RGBA : GL_RGB;
            glTexImage2D(ID, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
            glGenerateMipmap(GL_TEXTURE_2D);
        } else {
            std::cerr << "Can't load texture\n";
            return;
        }
    }

    ~Texture() {
        glDeleteTextures(1, &ID);
    }

    void bind() {
        glBindTexture(GL_TEXTURE_2D, ID);
    }
    
    void unbind() {
        glBindTexture(GL_TEXTURE_2D, 0);
    }

};


#endif //TEXTURE_HPP
