#ifndef SHADER_H
#define SHADER_H
#include <GL/glew.h>
#include <cglm/cglm.h>
#include <cglm/struct.h>

typedef unsigned int Shader;

Shader ShaderCreate(const char *vertex_path, const char *fragment_path);
void ShaderDestroy(Shader shader);
void ShaderUse(Shader shader);

void ShaderSetInt(Shader shader, const char *name, const int value);
void ShaderSetMat4(Shader shader, const char *name, mat4 value);

#endif
