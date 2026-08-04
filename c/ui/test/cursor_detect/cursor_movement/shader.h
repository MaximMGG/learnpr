#ifndef SHADER_H
#define SHADER_H

#include <cglm/cglm.h>
#include <cstdext/core.h>
#include <glad/glad.h>

typedef u32 Program;
typedef u32 Shader;


Program programLoad(str vec_path, str frag_path);
Shader programLoadShader(str path, u32 type);

void programUse(Program p);
void programDestroy(Program p);
void programSetInt(Program p, str uniform_name, i32 val);
void programSetMat4(Program p, str uniform_name, mat4 val);
void programSetVec4(Program p, str uniform_name, vec4 val);


#endif //SHADER_H
