#include "shader.h"
#include <cstdext/io/reader.h>

static bool programCheckStatus(u32 element, u32 type) {
  switch(type) {
    case GL_VERTEX_SHADER: {
      i32 status;
      glGetShaderiv(element, GL_COMPILE_STATUS, &status);
      if (status == GL_FALSE) {
        i8 buf[512] = {0};
        glGetShaderInfoLog(element, 512, null, buf);
        LOG(ERROR, "Compile VERTEX shader error: %s", buf);
        return false;
      }
    } break;
    case GL_FRAGMENT_SHADER: {
      i32 status;
      glGetShaderiv(element, GL_COMPILE_STATUS, &status);
      if (status == GL_FALSE) {
        i8 buf[512] = {0};
        glGetShaderInfoLog(element, 512, null, buf);
        LOG(ERROR, "Compile FRAGMENT shader error: %s", buf);
        return false;
      }
    } break;
    case 0: {
      i32 status;
      glGetProgramiv(element, GL_LINK_STATUS, &status);
      if (status == GL_FALSE) {
        i8 buf[512] = {0};
        glGetProgramInfoLog(element, 512, null, buf);
        LOG(ERROR, "Link program error: %s", buf);
        return false;
      }
    } break;
  }

  return true;
}

u32 programCompileShader(str path, u32 type) {
  str shader_source = readEntyreFile(path);
  if (shader_source == null) {
    LOG(ERROR, "Read shader file %s error", path);
    return 0;
  }
  u32 shader = glCreateShader(type);
  glShaderSource(shader, 1, (const i8 **)&shader_source, null);
  glCompileShader(shader);
  DEALLOC(shader_source);
  if (!programCheckStatus(shader, type)) {
    return 0;
  }
  return shader;
}


Shader shaderCreate(str vertex_path, str fragment_path) {
  u32 v_shader = programCompileShader(vertex_path, GL_VERTEX_SHADER);
  if (v_shader == 0) {
    LOG(ERROR, "programCreate failed");
    return (Shader){.id = 0};
  }
  u32 f_shader = programCompileShader(fragment_path, GL_FRAGMENT_SHADER);
  if (f_shader == 0) {
    LOG(ERROR, "programCreate failed");
    return (Shader){.id = 0};
  }
  Shader p;
  p.id = glCreateProgram();
  glAttachShader(p.id, v_shader);
  glAttachShader(p.id, f_shader);
  glLinkProgram(p.id);
  glDeleteShader(v_shader);
  glDeleteShader(f_shader);
  if(!programCheckStatus(p.id, 0)) {
    LOG(ERROR, "programCreate failed");
    return (Shader){.id = 0};
  }
  p.uniforms = mapCreate(POINTER(str), NUMERIC(i32), MAP_HASH_STR_FUNC, MAP_EQL_STR_FUNC);
  return p;
}

void shaderUse(Shader p) {
  glUseProgram(p.id);
}

void shaderDestroy(Shader p) {
  Iter *it = mapIter(p.uniforms);
  while(it->ok) {
    DEALLOC(it->key);
    iterNext(it);
  }
  iterDestroy(it);
  mapDestroy(p.uniforms);
  glDeleteProgram(p.id);
}

static i32 shaderGetUniformLocation(Shader p, str uniform_name) {
  KV kv = mapGet(p.uniforms, uniform_name);
  if (kv.key != null) {
    return *((i32 *)(kv.val));
  }
  i32 loc = glGetUniformLocation(p.id, uniform_name);
  if (loc == -1) {
    LOG(ERROR, "Can't find uniform location: %s", uniform_name);
    return -1;
  }
  mapInsert(p.uniforms, strCopy(uniform_name), &loc);
  return loc;
}

void shaderSetUniformInt(Shader p, str uniform_name, i32 val) {
  i32 loc = shaderGetUniformLocation(p, uniform_name);
  if (loc == -1) {
    return;
  }
  glUniform1i(loc, val);
}
void shaderSetUniformFloat(Shader p, str uniform_name, f32 val) {
  i32 loc = shaderGetUniformLocation(p, uniform_name);
  if (loc == -1) {
    return;
  }
  glUniform1f(loc, val);
}
void shaderSetUniformVec2(Shader p, str uniform_name, vec2 val) {
  i32 loc = shaderGetUniformLocation(p, uniform_name);
  if (loc == -1) {
    return;
  }
  glUniform2fv(loc, 1, val);
}

void shaderSetUniformVec3(Shader p, str uniform_name, vec3 val) {
  i32 loc = shaderGetUniformLocation(p, uniform_name);
  if (loc == -1) {
    return;
  }
  glUniform3fv(loc, 1, val);
}
void shaderSetUniformVec4(Shader p, str uniform_name, vec4 val) {
  i32 loc = shaderGetUniformLocation(p, uniform_name);
  if (loc == -1) {
    return;
  }
  glUniform4fv(loc, 1, val);
}  
void shaderSetUniformMat4(Shader p, str uniform_name, mat4 val) {
  i32 loc = shaderGetUniformLocation(p, uniform_name);
  if (loc == -1) {
    return;
  }
  glUniformMatrix4fv(loc, 1, GL_FALSE, &val[0][0]);
}  
