#include "render.hpp"

bool GLLogCall(const char *func, const int line) {
    unsigned int res;
    while((res = glGetError())) {
        std::printf("[OpenGL Error]: 0x%X :%s - %d\n", res, func, line);
        return false;
    }
    return true;
}
