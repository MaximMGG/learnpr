#include "error.h"

void resetError() {
    while(glGetError() != 0);
}

void checkError(const char *func, const int line, const char *code) {
    int err_code;
    while((err_code = glGetError()) != 0) {
        fprintf(stderr, "OpenGL error: [%s] %s - %d => 0x%X - %s\n", code, func, line, err_code, glewGetErrorString(err_code));
    }
}
