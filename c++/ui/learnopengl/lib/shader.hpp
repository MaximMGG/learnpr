#ifndef SHADER_HPP
#define SHADER_HPP
#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <GL/glew.h>
#include "glcall.hpp"

class Shader {
public:
    unsigned int id;
    std::map<std::string, int> uniforms;

    Shader(const char *v_path, const char *f_path) {
        unsigned int v_shader = compileShader(v_path, GL_VERTEX_SHADER);
        unsigned int f_shader = compileShader(f_path, GL_FRAGMENT_SHADER);
        id = glCreateProgram();
        GLCall(glAttachShader(id, v_shader));
        GLCall(glAttachShader(id, f_shader));
        GLCall(glLinkProgram(id));
        GLCall(glDeleteShader(v_shader));
        GLCall(glDeleteShader(f_shader));
        if (!checkStatus(id, GL_PROGRAM)) {
           GLCall(glDeleteProgram(id));
            return;
        }
        GLCall(glValidateProgram(id));
    }
    ~Shader() {
        GLCall(glDeleteProgram(id));
    }
    void use() {
        GLCall(glUseProgram(id));
    }
    void setInt(const char *name, int value) {
        auto it = uniforms.find(name);
        if (it != uniforms.end()) {
            GLCall(glUniform1i(it->second, value));
        } else {
            int loc;
            GLCall(loc = glGetUniformLocation(id, name));
            if (loc != -1) {
                uniforms[name] = loc;
            } else {
                std::cerr << "Can't find location " << name << '\n';
            }
        }
    }

    void setVec3(const char *name, glm::vec3 value) {
        auto it = uniforms.find(name);
        if (it != uniforms.end()) {
            GLCall(glUniform3fv(it->second, 1, &value[0]));
        } else {
            int loc;
            GLCall(loc = glGetUniformLocation(id, name));
            if (loc != -1) {
                GLCall(glUniform3fv(loc, 1, &value[0]));
                uniforms[name] = loc;
            } else {
                std::cerr << "Con't find location " << name << '\n';
            }
        }
    }

    void setMat4(const char *name, glm::mat4 value) {
        auto it = uniforms.find(name);
        if (it != uniforms.end()) {
            GLCall(glUniformMatrix4fv(it->second, 1, GL_FALSE, &value[0][0]));
        } else {
            int loc;
            GLCall(loc = glGetUniformLocation(id, name));
            if (loc != -1) {
                uniforms[name] = loc;
            } else {
                std::cerr << "Can't find location " << name << '\n';
            }
        }
    }

private:
    unsigned int compileShader(const char *path, unsigned int type) {
        std::ifstream file(path);
        if (file.is_open()) {
            file.seekg(0, std::ios::end);
            long file_size = file.tellg();
            file.seekg(0, std::ios::beg);
            char *buf = new char[file_size];
            file.read(buf, file_size);
            unsigned int shader;
            GLCall(shader = glCreateShader(type));
            GLCall(glShaderSource(shader, 1, &buf, NULL));
            GLCall(glCompileShader(shader));
            if (!checkStatus(shader, type)) {
                GLCall(glDeleteShader(shader));
                return 0;
            }
            return shader;
        } else {
            std::cerr << "Open file " << path << " error\n";
            return 0;
        }

        return 0;
    }

    bool checkStatus(unsigned int shader, unsigned int type) {
        if (type == GL_VERTEX_SHADER || type == GL_FRAGMENT_SHADER) {
            int res;
            GLCall(glGetShaderiv(shader, GL_COMPILE_STATUS, &res));
            if (res == GL_FALSE) {
                int len;
                GLCall(glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len));
                char *err_msg = new char[len];
                GLCall(glGetShaderInfoLog(shader, len, &len, err_msg));
                std::cerr << "Compile " << (type == GL_VERTEX_SHADER ? "vertex" : "fragment") << "shader failed: "
                    << err_msg << '\n';
                delete [] err_msg;
                return false;
            }
        } else if (type == GL_PROGRAM) {
            int res;
            GLCall(glGetProgramiv(shader, GL_LINK_STATUS, &res));
            if (res == GL_FALSE) {
                int len;
                GLCall(glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len));
                char *err_msg = new char[len];
                GLCall(glGetProgramInfoLog(shader, len, &len, err_msg));
                std::cerr << "Link program failed: " << err_msg << '\n';
                delete [] err_msg;
                return false;
            }
        }
        return true;
    }
};

#endif //SHADER_HPP
