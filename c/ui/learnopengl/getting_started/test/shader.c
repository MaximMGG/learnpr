#include "shader.h"
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>
#include <glad/glad.h>


static bool programCheckStatus(u32 element, u32 type) {

  switch(type) {
  case GL_VERTEX_SHADER: {
    i32 status;
    glGetShaderiv(element, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
      i8 buf[512] = {0};
      glGetShaderInfoLog(element, 512, null, buf);
      log(ERROR, "Compile VERTEX shader error: %s",buf);
      glDeleteShader(element);
      return false;
    }
  } break;
  case GL_FRAGMENT_SHADER: {
    i32 status;
    glGetShaderiv(element, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
      i8 buf[512] = {0};
      glGetShaderInfoLog(element, 512, null, buf);
      log(ERROR, "Compile FRAGMENT shader error: %s", buf);
      glDeleteShader(element);
      return false;
    }
  } break;
  case 0: {
    i32 status;
    glGetProgramiv(element, GL_LINK_STATUS, &status);
    if (status == GL_FALSE) {
      i8 buf[512] = {0};
      glGetProgramInfoLog(element, 512, null, buf);
      log(ERROR, "Link program error: %s", buf);
      return false;
    }
  } break;
  }

  return true;
}

static u32 programCompileShader(str shader_path, u32 shader_type) {
 str shader_source = readEntyreFile(shader_path);
  if (shader_source == null) {
    log(ERROR, "readEntyreFile error");
    return 0;
  }
  
  u32 shader = glCreateShader(shader_type);
  glShaderSource(shader, 1, (const i8 **)&shader_source, null);
  glCompileShader(shader);
  if (!programCheckStatus(shader, shader_type)) {
    glDeleteShader(shader);
    DEALLOC(shader_source);
    return 0;
  }

  DEALLOC(shader_source);
  return shader;
}


Program programCreate(str vertex_path, str fragment_path) {
  u32 v_s = programCompileShader(vertex_path, GL_VERTEX_SHADER);
  if (v_s == 0) {
    return 0;
  }
  u32 f_s = programCompileShader(fragment_path, GL_FRAGMENT_SHADER);
  if (f_s == 0) {
    return 0;
  }

  u32 prog = glCreateProgram();
  glAttachShader(prog, v_s);
  glAttachShader(prog, f_s);
  glLinkProgram(prog);
  glDeleteShader(v_s);
  glDeleteShader(f_s);
  if (!programCheckStatus(prog, 0)) {
    glDeleteProgram(prog);
    return 0;
  }

  return prog;
}
void programUse(Program p) {
  glUseProgram(p);
}

static i32 programGetUniformLocation(Program p, str uniform_name) {
  i32 loc = glGetUniformLocation(p, uniform_name);
  if (loc == -1) {
    log(ERROR, "Can't find location of uniform %s", uniform_name);
    return -1;
  }
  return loc;
}


void programSetUniformInt(Program p, str uniform_name, i32 val){
  i32 loc = programGetUniformLocation(p, uniform_name);
  glUniform1i(loc, val);
}
void programSetUniformFloat(Program p, str uniform_name, f32 val){
  i32 loc = programGetUniformLocation(p, uniform_name);
  glUniform1f(loc, val);
}
void programSetUniformVec4(Program p, str uniform_name, vec4 val){
  i32 loc = programGetUniformLocation(p, uniform_name);
  glUniform4fv(loc, 1, val);
}
void programSetUniformMat4(Program p, str uniform_name, mat4 val) {
  i32 loc = programGetUniformLocation(p, uniform_name);
}
