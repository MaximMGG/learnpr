#ifndef SHADER_HPP
#define SHADER_HPP

#include <GL/glew.h>
#include <map>
#include <string>
#include <fstream>
#include <iostream>
#include <string.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

class Shader {
public:
  unsigned int id;
  std::map<std::string, int> location;

  Shader(const char *vertexPath, const char *fragmentPath) {
    unsigned int vertexShader = compileShader(vertexPath, GL_VERTEX_SHADER);
    if (vertexShader == 0) {
      this->id = 0;
      return;
    }

    unsigned int fragmentShader = compileShader(fragmentPath, GL_FRAGMENT_SHADER);
    if (fragmentShader == 0) {
      this->id = 0;
      return;
    }
    unsigned int program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    if (!checkStatus(program, GL_PROGRAM)) {
      glDeleteProgram(program);
      this->id = 0;
      return;
    }
    glValidateProgram(program);
    this->id = program;
  }

  ~Shader() {
    glDeleteProgram(this->id);
  }

  void use() {
    glUseProgram(this->id);
  }

  void setInt(const char *name, int val) {
    int location = getLocation(name);
    glUniform1i(location, val);
  }
  void setMat4(const char *name, glm::mat4 &val) {
    int location = getLocation(name);
    glUniformMatrix4fv(location, 1, GL_FALSE, &val[0][0]);
  }

private:
  unsigned int compileShader(const char *path, int type) {
    std::ifstream f(path);
    if (f.is_open()) {
      f.seekg(0, std::ios_base::end);
      long file_size = f.tellg();
      f.seekg(0, std::ios_base::beg);
      char *buf = new char[file_size + 1];
      memset(buf, 0, file_size + 1);
      f >> buf;

      unsigned int shader = glCreateShader(type);
      glShaderSource(shader, 1, &buf, NULL);
      glCompileShader(shader);
      delete [] buf;
      if (!checkStatus(shader, type)) {
        return 0;
      }
    } else {
      std::cerr << "fstream error\n";
      return 0;
    }
    return 0;
  }

  bool checkStatus(unsigned int shader, int type) {
    switch(type) {
      case GL_VERTEX_SHADER: {
        int result;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &result);
        if (result == GL_FALSE) {
          int len;
          glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
          char *err_buf = new char[len + 1];
          memset(err_buf, 0, len + 1);
          glGetShaderInfoLog(shader, len, &len, err_buf);
          std::cerr << "Error compile VERTEX shader: " << err_buf << '\n';
          delete [] err_buf;
          return false;
        }
      } break;
      case GL_FRAGMENT_SHADER: {
        int result;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &result);
        if (result == GL_FALSE) {
          int len;
          glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
          char *err_buf = new char[len + 1];
          memset(err_buf, 0, len + 1);
          glGetShaderInfoLog(shader, len, &len, err_buf);
          std::cerr << "Error compile FRAGMENT shader: " << err_buf << '\n';
          delete [] err_buf;
          return false;
        }

      } break;
      case GL_PROGRAM: {
        int result;
        glGetProgramiv(shader, GL_LINK_STATUS, &result);
        if (result == GL_FALSE) {
          int len;
          glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len);
          char *err_buf = new char[len + 1];
          memset(err_buf, 0, len + 1);
          glGetProgramInfoLog(shader, len, &len, err_buf);
          std::cerr << "Error link program: " << err_buf << '\n';
          delete [] err_buf;
          return false;
        }
      } break;
    }

    return true;
  }

  int getLocation(const char *name) {
    if (this->location.find(name) == this->location.end()) {
      int location = glGetUniformLocation(this->id, name);
      this->location[name] = location;
      return location;
    } else {
      return this->location[name];
    }
  }
};





#endif
