#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

typedef struct {
    double r;
    double g;
    double b;
}Vec3;

void write_color(int fd, Vec3 vec) {
    int rb = (int)(255.999 * vec.r);
    int gb = (int)(255.999 * vec.g);
    int bb = (int)(255.999 * vec.b);

    char buf[512] = {0};
    sprintf(buf, "%d %d %d\n", rb, gb, bb);

    write(fd, buf, strlen(buf));
}

int main() {

    int width = 256;
    int height = 256;

    printf("P3\n%d %d\n255\n", width, height);

    for(int j = 0; j < height; j++) {
        fprintf(stderr, "\rScanlines remaining: %d ", (height - j));
        for (int i = 0; i < width; i++) {

            Vec3 vec = {
                .r = ((double) i) / (width - 1),
                .g = ((double) j) / (height - 1),
                .b = 0.0
            };

            write_color(STDOUT_FILENO, vec);
        }
    }

    return 0;
}
