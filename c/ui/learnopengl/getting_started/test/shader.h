#ifndef SHADER_H
#define SHADER_H

#include <cglm/cglm.h>
#include <cstdext/core.h>


typedef u32 Program;


Program programCreate(str vertex_path, str fragment_path);
void programUse(Program p);

void programSetUniformInt(Program p, str uniform_name, i32 val);
void programSetUniformFloat(Program p, str uniform_name, f32 val);
void programSetUniformVec4(Program p, str uniform_name, vec4 val);
void programSetUniformMat4(Program p, str uniform_name, mat4 val);  


#endif //SHADER_H

