#ifndef SHADER_H
#define SHADER_H

#include <cstdext/core.h>
#include <cstdext/io/reader.h>
#include <cstdext/io/logger.h>
#include <cstdext/container/map.h>
#include "renderer.h"

typedef enum ShaderType {
    NONE = -1, VERTEX = 0, FRAGMENT = 1
} ShaderType;

typedef struct {
  str VertexSource;
  str FragmentSource;
} ShaderProgramSource;

typedef struct {
    const char *filepath;
    u32 rendererID;
    map *uniformLocationCache;
} Shader;

Shader ShaderCreate(char *filepath);
void ShaderDestroy(Shader *s);

void ShaderBind(Shader *s);
void ShaderUnbind(Shader *s);

//Set uniforoms
void ShaderSetUniform4f(Shader *s, const char *name, float v0, float v1, float v2, float v3);
void ShaderSetUniform1i(Shader *s, const char *name, u32 v0);

#endif //SHADER_H
