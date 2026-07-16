#include "shader.h"
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>

bool programCheckStatus(u32 element, u32 type) {
  switch(type) {
  case GL_VERTEX_SHADER: {
    i32 status;
    glGetShaderiv(element, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
      byte err_msg[512];
      glGetShaderInfoLog(element, 512, null, err_msg);
      log(ERROR, "Compile vertex shader error: ", err_msg);
      return false;
    }
  } break;
  case GL_FRAGMENT_SHADER: {
    i32 status;
    glGetShaderiv(element, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
      byte err_msg[512];
      glGetShaderInfoLog(element, 512, null, err_msg);
      log(ERROR, "Compile fragment shader error: ", err_msg);
      return false;
    }
  } break;
  case 0: {
    i32 status;
    glGetProgramiv(element, GL_LINK_STATUS, &status);
    if (status == GL_FALSE) {
      byte err_msg[512];
      glGetProgramInfoLog(element, 512, null, err_msg);
      log(ERROR, "Link program error: ", err_msg);
      return false;
    }
  } break;
  }

  return true;
}

Program programLoad(str vertex_path, str frag_path) {
  u32 v_shader = programLoadShader(vertex_path, GL_VERTEX_SHADER);
  if (v_shader == 0) {
    log(ERROR, "programLoad vertex shader error");
    return 0;
  }
  u32 f_shader = programLoadShader(frag_path, GL_FRAGMENT_SHADER);
  if (f_shader == 0) {
    log(ERROR, "programLoad fragment shader error");
  }

  u32 prog = glCreateProgram();
  glAttachShader(prog, v_shader);
  glAttachShader(prog, f_shader);
  glLinkProgram(prog);
  glDeleteShader(v_shader);
  glDeleteShader(f_shader);
  if (!programCheckStatus(prog, 0)) {
    log(ERROR, "programLoad link program error");
    return 0;
  }

  return prog;
}
Shader programLoadShader(str path, u32 type) {
  byte *source = readEntyreFile(path);
  if (source == null) {
    log(ERROR, "Read shader source error");
    return 0;
  }
  u32 shader = glCreateShader(type);
  glShaderSource(shader, 1, (const char **)&source, null);
  glCompileShader(shader);
  if (!programCheckStatus(shader, type)) {
    log(ERROR, "programLoadShader error");
    return 0;
  }
  return shader;
}

void programUse(Program p) {
  glUseProgram(p);
}

void programDestroy(Program p) {
  glDeleteProgram(p);
}

i32 programGetLocation(Program p, str name) {
  i32 loc = glGetUniformLocation(p, name);
  if (loc == -1) {
    log(ERROR, "Didn't find location of uniform %s", name);
    return -1;
  }
  return loc;
}

void programSetInt(Program p, str uniform_name, i32 val) {
  glUniform1i(programGetLocation(p, uniform_name), val);
}

void programSetMat4(Program p, str uniform_name, mat4 val) {
  glUniformMatrix4fv(programGetLocation(p, uniform_name), 1, GL_FALSE, &val[0][0]);
}

void programSetVec4(Program p, str uniform_name, vec4 val) {
  glUniform3fv(programGetLocation(p, uniform_name), 1, &val[0]);
}
