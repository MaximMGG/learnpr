#include <glad/glad.h>
#include <glm/fwd.hpp>
#include <mh/core/types.hpp>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <glm/glm.hpp>


enum ShaderType {
  VERTEX, FRAGMENT, PROGRAM
};

class Shader {
public:
  u32 ID;
  bool success = true;

  Shader(const i8 *vertexPath, const i8 *fragmentPath) {
    u32 v_s = compileShader(vertexPath, VERTEX);
    if (v_s == 0) {
      success = false;
      return;
    }
    u32 f_s = compileShader(fragmentPath, FRAGMENT);
    if (f_s == 0) {
      success = 0;
      return;
    }
    
    ID = glCreateProgram();
    glAttachShader(ID, v_s);
    glAttachShader(ID, f_s);
    glLinkProgram(ID);
    glDeleteShader(v_s);
    glDeleteShader(f_s);
    if (!checkStatus(ID, PROGRAM)) {
      success = false;
      return;
    }
    glValidateProgram(ID);
  }
  
  ~Shader() {
    glDeleteProgram(ID);
  }

  void use() {
    glUseProgram(ID);
  }

  void setInt(const i8 *uniform, i32 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniform1i(loc, val);
  }
  void setFloat(const i8 *uniform, f32 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniform1f(loc, val);
  }
  void setVec2 (const i8 *uniform, glm::vec2 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniform2fv(loc, 1, &val[0]);
  }
  void setVec3(const i8 *uniform, glm::vec3 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniform3fv(loc, 1, &val[0]);
  }
  void setVec4(const i8 *uniform, glm::vec4 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniform4fv(loc, 1, &val[0]);
  }
  
  void setMat2 (const i8 *uniform, glm::mat2 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniformMatrix2fv(loc, 1, GL_FALSE, &val[0][0]);
  }
  
  void setMat3 (const i8 *uniform, glm::mat3 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniformMatrix3fv(loc, 1, GL_FALSE, &val[0][0]);
  }
  
  void setMat4 (const i8 *uniform, glm::mat4 val) {
    i32 loc = getUnifromLocation(uniform);
    if (loc == -1) {
      return;
    }
    glUniformMatrix4fv(loc, 1, GL_FALSE, &val[0][0]);
  }

private:

  i32 getUnifromLocation(const i8 *uniform) {
    i32 location = glGetUniformLocation(ID, uniform);
    if (location == -1) {
      return -1;
    }
    return location;
  }

  bool checkStatus(u32 element, ShaderType type) {
    switch(type) {
    case VERTEX:
    case FRAGMENT: {
      i32 status;
      glGetShaderiv(element, GL_COMPILE_STATUS, &status);
      if (status == GL_FALSE) {
        i8 buf[1024]{0};
        glGetShaderInfoLog(element, 1024, nullptr, buf);
        fprintf(stderr, "Compile %s shader error: %s\n", type == VERTEX ? "VERTEX" : "FRAGMENT", buf);
        return false;
      }
    } break;
    case PROGRAM: {
      i32 status;
      glGetProgramiv(element, GL_LINK_STATUS, &status);
      if (status == GL_FALSE) {
        i8 buf[1024]{0};
        glGetProgramInfoLog(element, 1024, nullptr, buf);
        fprintf(stderr, "Link program error: %s\n", buf);
        return false;
      }
    } break;
    }
    return true;
  }
  
  u32 compileShader(const i8 *path, ShaderType type) {
    i32 fd = open(path, O_RDONLY);
    if (fd <= 0) {
      fprintf(stderr, "Can't open file %s\n", path);
    }
    u64 file_size = lseek(fd, 0, SEEK_END);
    i8 *buf = new i8 [file_size + 1];
    lseek(fd, 0, SEEK_SET);
    u32 read_bytes = read(fd, buf, file_size);
    if (read_bytes != file_size) {
      fprintf(stderr, "read syscall error read_bytes != file size %d - %ld\n", read_bytes, file_size);
      delete [] buf;
      return 0;
    }
    buf[read_bytes] = '\0';

    u32 shader = glCreateShader(type == VERTEX ? GL_VERTEX_SHADER : GL_FRAGMENT_SHADER);
    glShaderSource(shader, 1, &buf, nullptr);
    glCompileShader(shader);
    delete [] buf;
    if (!checkStatus(shader, type)) {
      fprintf(stderr, "Compile shader error\n");
      return 0;
    }
    return shader;
  }
  
};
