#ifndef SHADER_H
#define SHADER_H
#include <cglm/cglm.h>
#include <GL/glew.h>
#include <cstdext/core.h>
#include <cstdext/io/reader.h>
#include <cstdext/io/logger.h>
#include "error.h"

u32 programCreate(const char *v_path, const char *f_path);
void programUse(u32 program);
void programUnuse(u32 program);
void programDestroy(u32 program);
void programSetI(u32 program, const char *name, i32 value);
void programSetMat4(u32 program, const char *name, mat4 value);

#endif //SHADER_H
