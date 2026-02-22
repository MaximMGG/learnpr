package util


// #define GLCall(x)       while(glGetError() != 0);   \
//                         int _res_err_ = 0;          \
//                         (x);                        \
//                         while((_res_err_ = glGetError()) != 0) fprintf(stderr, "GLCall error: 0x%x: %s -> %s %d [%s]",  \
//                             _res_err_, glewGetErrorString(_res_err_),                                                   \
//                                       __FUNCTION__, __LINE__, #x)


import gl "vendor:OpenGL"
import "core:fmt"

glCheckErr :: proc() {
  for res: u32 = gl.GetError(); res != 0; res = gl.GetError() {
    fmt.eprintln("gl.error:", res)
  }
}
