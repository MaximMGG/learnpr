#ifndef SHADER_H
#define SHADER_H
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/map.h>
#include <glad/glad.h>
#include <cglm/cglm.h>

typedef struct {
  u32 id;
  Map *uniforms;
} Shader;

Shader shaderCreate         (str vertex_path, str fragment_path);
void   shaderUse            (Shader p);
void   shaderDestroy        (Shader p);
void   shaderSetUniformInt  (Shader p, str uniform_name, i32 val);
void   shaderSetUniformFloat(Shader p, str uniform_name, f32 val);
void   shaderSetUniformVec2 (Shader p, str uniform_name, vec2 val);
void   shaderSetUniformVec3 (Shader p, str uniform_name, vec3 val);
void   shaderSetUniformVec4 (Shader p, str uniform_name, vec4 val);
void   shaderSetUniformMat4 (Shader p, str uniform_name, mat4 val);

#endif //SHADER_H
