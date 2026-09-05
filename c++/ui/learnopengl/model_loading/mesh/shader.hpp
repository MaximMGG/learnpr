#ifndef MY_SHADER_HPP
#define MY_SHADER_HPP

#include <glad/glad.h>
#include <glm/glm.hpp>

#include <string>
#include <fstream>
#include <sstream>
#include <iostream>

#include "types.hpp"

class Shader {
public:
  u32 id;

  Shader(const char *vertex_path, const char *fragment_path) {
    std::string vertex_source;
    std::string fragment_source;
    std::ifstream v_stream;
    std::ifstream f_stream;

    v_stream.exceptions(std::ifstream::failbit | std::ifstream::badbit);
    f_stream.exceptions(std::ifstream::failbit | std::ifstream::badbit);

    v_stream.open(vertex_path);
    f_stream.open(fragment_path);
    std::stringstream v_stream_s, f_stream_s;

    v_stream_s << v_stream.rdbuf();
    f_stream_s << f_stream.rdbuf();

    vertex_source = v_stream_s.str();
    fragment_source = f_stream_s.str();

    const char *vertex_code = vertex_source.c_str();
    const char *fragment_code = fragment_source.c_str();

    u32 vertex, fragment;

    vertex = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertex, 1, &vertex_code, NULL);
    glCompileShader(vertex);
    if (!checkCompileErrors(vertex, GL_VERTEX_SHADER)) {
      this->id = 0;
      glDeleteShader(vertex);
      return;
    }
    fragment = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragment, 1, &fragment_code, NULL);
    glCompileShader(fragment);
    if (!checkCompileErrors(fragment, GL_FRAGMENT_SHADER)) {
      this->id = 0;
      glDeleteShader(vertex);
      glDeleteShader(fragment);
      return;
    }
    this->id = glCreateProgram();
    glAttachShader(this->id, vertex);
    glAttachShader(this->id, fragment);
    glLinkProgram(this->id);
    glDeleteShader(vertex);
    glDeleteShader(fragment);
    if (!checkCompileErrors(this->id, 0)) {
      this->id = 0;
      return;
    }
  }

  void setInt(const char *name, i32 val) {
    i32 loc = getUniformLocation(name);
    if (loc != -1) {
      glUniform1i(loc, val);
    }
  }
  void setFloat(const char *name, f32 val) {
    i32 loc = getUniformLocation(name);
    if (loc != -1) {
      glUniform1f(loc, val);
    }
  }
  void setVec2(const char *name, glm::vec2 val) {
    i32 loc = getUniformLocation(name);
    if (loc != -1) {
      glUniform2fv(loc, 1, &val[0]);
    }
  }
  void setVec3(const char *name, glm::vec3 val) {
    i32 loc = getUniformLocation(name);
    if (loc != -1) {
      glUniform3fv(loc, 1, &val[0]);
    }
  }
  void setVec4(const char *name, glm::vec4 val) {
    i32 loc = getUniformLocation(name);
    if (loc != -1) {
      glUniform4fv(loc, 1, &val[0]);
    }
  }
  void setMat4(const char *name, glm::mat4 val) {
    i32 loc = getUniformLocation(name);
    if (loc != -1) {
      glUniformMatrix4fv(loc, 1, GL_FALSE, &val[0][0]);
    }
  }



private:


  i32 getUniformLocation(const char *name) {
    i32 loc = glGetUniformLocation(this->id, name);
    if (loc == -1) {
      std::cerr << "Can't find uniform " << name << '\n';
      return -1;
    }
    return loc;
  }

  bool checkCompileErrors(u32 shader, u32 type) {

    switch(type) {
      case GL_VERTEX_SHADER: {
        i32 status;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
        if (status == GL_FALSE) {
          char buf[512] = {0};
          glGetShaderInfoLog(shader, 512, NULL, buf);
          std::cerr << "Compile VERTEX shader error: " << buf << '\n';
          return false;
        }
      } break;
      case GL_FRAGMENT_SHADER: {
        i32 status;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
        if (status == GL_FALSE) {
          char buf[512] = {0};
          glGetShaderInfoLog(shader, 512, NULL, buf);
          std::cerr << "Compile FRAGMENT shader error: " << buf << '\n';
          return false;
        }
      } break;
      case 0: {
        i32 status;
        glGetProgramiv(shader, GL_LINK_STATUS, &status);
        if (status == GL_FALSE) {
          char buf[512] = {0};
          glGetProgramInfoLog(shader, 512, NULL, buf);
          std::cerr << "Link program error: " << buf << '\n';
          return false;
        }
      } break;
    }
    return true;
  }

};



#endif
