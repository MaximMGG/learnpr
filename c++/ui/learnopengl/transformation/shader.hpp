#ifndef SHADER_HPP
#define SHADER_HPP

#include <GL/glew.h>
#include <map>
#include <string>
#include <fstream>
#include <iostream>
#include <string.h>

class Shader {
public:
  unsigned int id;
  std::map<std::string, int> location;

  Shader(std::string &vertexPath, std::string &fragmentPath) {
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

private:
  unsigned int compileShader(std::string &path, int type) {
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
};





#endif
