#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define LOG_ERROR(msg, ...)         \
        fprintf(stderr, msg, __VA_ARGS__); \
        exit(EXIT_FAILURE)


int main(int argc, char **argv) {
    if (argc < 3) {
        LOG_ERROR("argc < 3 shod be more then %d\n", 3);
    }
    if (strcmp(argv[2], "No") != 0) {
        LOG_ERROR("argv[2] do not equals to %s, argv[2] is %s\n", "No", argv[2]);
    }
}
