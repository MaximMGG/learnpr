#ifndef RENDERER_H
#define RENDERER_H
#include <cstdext/core.h>
#include <stdio.h>

#define GLCall(x) GLClearError(); \
  x;\
  ASSERT(GLLogCall(#x, __LINE__))

#define ASSERT(x) if (!(x)) fprintf(stderr, "Err: %s:%d\n", __FUNCTION__, __LINE__);

void GLClearError();
bool GLLogCall(const str func, const int line);


#endif //RENDERER_H
