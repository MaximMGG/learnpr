#include "Shader.h"
#include <GL/glew.h>
#include <stdio.h>
#include <string.h>


static ShaderProgramSource ShaderParseShader(str file) {
  reader *r = reader_create_from_file(file);
  str_buf *sb[2] = {str_buf_create(), str_buf_create()};

  u32 type;
  ShaderType st = NONE;
  
  str line;
  while((line = reader_read_until_del(r, '\n')) != null) {
    if (strstr(line, "#shader") != null) {
      if (strstr(line, "vertex") != null) {
	st = VERTEX;
      } else if (strstr(line, "fragment") != null) {
	st = FRAGMENT;
      }
    } else {
      str_buf_append_format(sb[st], "%s\n", line);
    }
  }
  ShaderProgramSource prog = {.VertexSource = str_buf_to_string(sb[0]), .FragmentSource = str_buf_to_string(sb[1])};
  str_buf_destroy(sb[0]);
  str_buf_destroy(sb[1]);

  return prog;
}

static u32 ShaderCompileShader(const str source, u32 type) {
  u32 id = glCreateShader(type);
  GLCall(glShaderSource(id, 1, (const char *const *)&source, null));
  GLCall(glCompileShader(id));

  i32 result;
  GLCall(glGetShaderiv(id, GL_COMPILE_STATUS, &result));
  if (result == GL_FALSE) {
    i32 length;
    GLCall(glGetShaderiv(id, GL_INFO_LOG_LENGTH, &length));
    byte *message = (byte *)alloca(length + 1);
    GLCall(glGetShaderInfoLog(id, length, &length, message));
    log(ERROR, "Failed compile %s shader %s", type == GL_VERTEX_SHADER ? "vertex" : "fragment", message);
    GLCall(glDeleteShader(id));
    return 0;
  }
  
  return id;
}

static u32 ShaderCreateShader(const str vertexShader, const str fragmentShader) {
  u32 program = glCreateProgram();
  u32 vs = ShaderCompileShader(vertexShader, GL_VERTEX_SHADER);
  u32 fs = ShaderCompileShader(fragmentShader, GL_FRAGMENT_SHADER);

  GLCall(glAttachShader(program, vs));
  GLCall(glAttachShader(program, fs));
  GLCall(glLinkProgram(program));
  GLCall(glValidateProgram(program));

  GLCall(glDeleteShader(vs));
  GLCall(glDeleteShader(fs));
  
  return program;
}


Shader ShaderCreate(char *filepath) {
    Shader s = {.filepath = filepath};

    ShaderProgramSource source = ShaderParseShader(filepath);
    s.rendererID = ShaderCreateShader(source.VertexSource, source.FragmentSource);
    s.uniformLocationCache = map_create(STR, I32, null, null);

    return s;
}
void ShaderDestroy(Shader *s) {
    GLCall(glDeleteProgram(s->rendererID));
    map_destroy(s->uniformLocationCache);
}

void ShaderBind(Shader *s) {
    GLCall(glUseProgram(s->rendererID));
}

void ShaderUnbind(Shader *s) {
    GLCall(glUseProgram(0));
}

static i32 ShaderGetUniformLocation(Shader *s, const char *name) {
    if (map_contain(s->uniformLocationCache, (ptr)name)) {
        return *(i32 *)map_get(s->uniformLocationCache, (ptr)name).val;
    }

    i32 location = 0;
    GLCall(location = glGetUniformLocation(s->rendererID, name));
    if (location == -1) {
        log(ERROR, "Cant find shader %s variable %s location", s->filepath, name);
        return -1;
    }

    map_put(s->uniformLocationCache, (ptr)name, &location);

    return location;
}

void ShaderSetUniform4f(Shader *s, const char *name, float v0, float v1, float v2, float v3) {
    GLCall(glUniform4f(ShaderGetUniformLocation(s, name), v0, v1, v2, v3));

}

void ShaderSetUniform1i(Shader *s, const char *name, u32 v0) {
    GLCall(glUniform1i(ShaderGetUniformLocation(s, name), v0));
}
