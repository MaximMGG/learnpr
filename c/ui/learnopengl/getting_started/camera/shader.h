#ifndef SHADER_H
#define SHADER_H

#include <glad/glad.h>
#include <cglm/cglm.h>
#include <cstdext/core.h>

typedef u32 Shader;

Shader shaderCreateProgram(str vertex_path, str fragment_path);
void shaderUse(Shader s);
void shaderDestroy(Shader s);

void shaderUniformInt(Shader s, str uniform_name, i32 val);
void shaderUniformFloat(Shader s, str uniform_name, f32 val);
void shaderUniformMat4(Shader s, str uniform_name, mat4 val);
void shaderUniformVec4(Shader s, str uniform_name, vec4 val);

#endif // SHADER_H
