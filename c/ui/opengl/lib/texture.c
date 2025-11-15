#include "texture.h"

u32 textureLoad(const char *path) {
    u32 texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

    i32 width, height, nrChennels;
    stbi_set_flip_vertically_on_load(true);
    unsigned char *data = stbi_load(path, &width, &height, &nrChennels, 0);

    if (data) {
        i32 format = nrChennels == 4 ? GL_RGBA : GL_RGB;
        glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data);
        glGenerateMipmap(GL_TEXTURE_2D);
    } else {
        log(ERROR, "Can not load texture: %s", path);
    }

    stbi_image_free(data);
    return texture;
}

void textureBind(u32 texture) {
    glBindTexture(GL_TEXTURE_2D, texture);
}
void textureUnbind() {
    glBindTexture(GL_TEXTURE_2D, 0);
}
void textureDestroy(u32 *texture) {
    glDeleteTextures(1, texture);
}

