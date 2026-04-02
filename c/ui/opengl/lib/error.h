#ifndef ERROR_H
#define ERROR_H
#include <GL/glew.h>
#include <cstdext/core.h>
#include <stdio.h>

#define GLCall(x)   resetError();                                       \
                    x;                                                  \
                    checkError(__FUNCTION__, __LINE__, #x)
                    

void resetError();
void checkError(const char *func, const int line, const char *code);


#endif //ERROR_H
