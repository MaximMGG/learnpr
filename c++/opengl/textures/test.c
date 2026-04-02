#define STB_IMAGE_IMPLEMENTATION
#define STBI_ASSERT(x)
#define STBI_NO_LINEAR
#include <math.h>
#include <stb/stb_image.h>


int main() {

    stbi_set_flip_vertically_on_load(1);

    int width, height, count;
    unsigned char *file = stbi_load("wall.jpg", &width, &height, &count, 0);

    printf("%s\n", file);

    stbi_image_free(file);

    return 0;
}
