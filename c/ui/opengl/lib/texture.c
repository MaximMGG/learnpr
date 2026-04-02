#include "texture.h"

u32 textureLoad(const char *path) {
    u32 texture;
    GLCall(glGenTextures(1, &texture));
    GLCall(glBindTexture(GL_TEXTURE_2D, texture));

    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT));
    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT));

    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR));
    GLCall(glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR));

    i32 width, height, nrChennels;
    stbi_set_flip_vertically_on_load(true);
    unsigned char *data = stbi_load(path, &width, &height, &nrChennels, 0);

    if (data) {
        i32 format = (nrChennels == 4 ? GL_RGBA : GL_RGB);
        GLCall(glTexImage2D(GL_TEXTURE_2D, 0, format, width, height, 0, format, GL_UNSIGNED_BYTE, data));
        GLCall(glGenerateMipmap(GL_TEXTURE_2D));
    } else {
        log(ERROR, "Can not load texture: %s", path);
    }

    stbi_image_free(data);
    return texture;
}

void textureBind(u32 texture) {
    GLCall(glBindTexture(GL_TEXTURE_2D, texture));
}
void textureUnbind() {
    GLCall(glBindTexture(GL_TEXTURE_2D, 0));
}
void textureDestroy(u32 *texture) {
    GLCall(glDeleteTextures(1, texture));
}

