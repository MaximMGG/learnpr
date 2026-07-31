#include "shader.h"
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>

typedef enum {

  VERTEX_SHADER_TYPE,
  FRAGMENT_SHADER_TYPE,
  PROGRAM_TYPE
} ShaderType;

bool shaderCheckStatus(u32 element, u32 type) {
  switch (type) {
  case GL_VERTEX_SHADER: {
    i32 status;
    glGetShaderiv(element, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
      i8 err_buf[512] = {0};
      glGetShaderInfoLog(element, 512, null, err_buf);
      log(ERROR, "COMPILE VERTEX shader error: %s", err_buf);
      return false;
    }
  } break;
  case GL_FRAGMENT_SHADER: {
    i32 status;
    glGetShaderiv(element, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
      i8 err_buf[512] = {0};
      glGetShaderInfoLog(element, 512, null, err_buf);
      log(ERROR, "COMPILE FRAGMENT shader error: %s", err_buf);
      return false;
    }
  } break;
  case 0: {
    i32 status;
    glGetProgramiv(element, GL_LINK_STATUS, &status);
    if (status == GL_FALSE) {
      i8 err_buf[512] = {0};
      glGetProgramInfoLog(element, 512, null, err_buf);
      log(ERROR, "Link program error: %s", err_buf);
      return false;
    }
  } break;
  }

  return true;
}

static u32 shaderCompileShader(str path, u32 gl_shader_type) {
  str shader_source = readEntyreFile(path);
  if (shader_source == null) {
    log(ERROR, "Read shader file %s errro", path);
    return 0;
  }
  u32 shader = glCreateShader(gl_shader_type);
  glShaderSource(shader, 1, (const char **)&shader_source, null);
  glCompileShader(shader);
  if (!shaderCheckStatus(shader, gl_shader_type)) {
    log(ERROR, "Compile shader errror");
    return 0;
  }

  return shader;
}

Shader shaderCreateProgram(str vertex_path, str fragment_path) {
  u32 v_shader = shaderCompileShader(vertex_path, GL_VERTEX_SHADER);
  if (v_shader == 0) {
    return 0;
  }
  u32 f_shader = shaderCompileShader(fragment_path, GL_FRAGMENT_SHADER);
  if (f_shader == 0) {
    return 0;
  }
  u32 program = glCreateProgram();
  glAttachShader(program, v_shader);
  glAttachShader(program, f_shader);
  glLinkProgram(program);
  if (!shaderCheckStatus(program, 0)) {
    return 0;
  }
  glDeleteShader(v_shader);
  glDeleteShader(f_shader);
  return program;
}

void shaderUse(Shader s) { glUseProgram(s); }

void shaderDestroy(Shader s) { glDeleteProgram(s); }

i32 shaderGetUniformLocation(Shader s, str name) {
  i32 location = glGetUniformLocation(s, name);
  if (location == -1) {
    log(ERROR, "Can't find location of uniform %s", name);
    return -1;
  }
  return location;
}

void shaderUniformInt(Shader s, str uniform_name, i32 val) {
  i32 location = shaderGetUniformLocation(s, uniform_name);
  if (location == -1)
    return;
  glUniform1i(s, val);
}

void shaderUniformFloat(Shader s, str uniform_name, f32 val) {
  i32 location = shaderGetUniformLocation(s, uniform_name);
  if (location == -1)
    return;
  glUniform1f(s, val);
}
void shaderUniformMat4(Shader s, str uniform_name, mat4 val) {
  i32 location = shaderGetUniformLocation(s, uniform_name);
  if (location == -1)
    return;
  glUniformMatrix4fv(s, 1, GL_FALSE, &val[0][0]);
}
void shaderUniformVec4(Shader s, str uniform_name, vec4 val) {
  i32 location = shaderGetUniformLocation(s, uniform_name);
  if (location == -1)
    return;
  glUniform4fv(s, 1, &val[0]);
}
