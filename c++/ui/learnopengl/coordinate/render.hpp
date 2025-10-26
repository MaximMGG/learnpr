#ifndef RENDER_HPP
#define RENDER_HPP
#include "GL/glew.h"
#include "GLFW/glfw3.h"
#include <cstdio>


#define GLCall(x)       \
while(glGetError());    \
    x;                  \
    GLASSERT(GLLogCall(#x, __LINE__)) 


#define GLASSERT(x) if (!(x)) fprintf(stderr, "Err: %s:%d\n", __FUNCTION__, __LINE__)

bool GLLogCall(const char *func, const int line);

#endif //RENDER_HPP
