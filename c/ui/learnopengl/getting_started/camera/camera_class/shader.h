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
} Program;

Program programCreate(str vertex_path, str fragment_path);
void programUse(Program p);
void programDestroy(Program p);
void programSetUniformInt(Program p, str uniform_name, i32 val);
void programSetUniformFloat(Program p, str uniform_name, f32 val);
void programSetUniformVec2(Program p, str uniform_name, vec2 val);
void programSetUniformVec4(Program p, str uniform_name, vec4 val);
void programSetUniformMat4(Program p, str uniform_name, mat4 val);

#endif //SHADER_H
