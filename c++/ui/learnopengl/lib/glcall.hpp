#ifndef OPENGL_LEARN_DEBUG_CALL_HPP
#define OPENGL_LEARN_DEBUG_CALL_HPP

//#define _GLCALL_

#ifdef _GLCALL_
#define GLCall(x)       while(glGetError() != 0);   \
                        int _res_err_ = 0;          \
                        (x);                        \
                        while((_res_err_ = glGetError()) != 0) fprintf(stderr, "GLCall error: 0x%x: %s -> %s %d [%s]",  \
                            _res_err_, glewGetErrorString(_res_err_),                                                   \
                                      __FUNCTION__, __LINE__, #x)
#else
#define GLCall(x) x
#endif

#endif //OPENGL_LEARN_DEBUG_CALL_HPP
