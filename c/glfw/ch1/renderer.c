#include "renderer.h"
#include <stdio.h>
#include <GL/glew.h>


void GLClearError() {
  while(glGetError());
}

bool GLLogCall(const str func, const int line) {
  u32 gl_err;
  while((gl_err = glGetError()) != GL_NO_ERROR) {
    fprintf(stderr, "[OpenGL Error] (0x%X): %s:%d\n", gl_err, func, line);
    return false;
  }

  return true;
}

