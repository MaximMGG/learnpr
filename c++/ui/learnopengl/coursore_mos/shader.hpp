#ifndef SHADER_HPP
#define SHADER_HPP
#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <GL/glew.h>

class Shader {
public:
    unsigned int id;
    std::map<std::string, int> uniforms;

    Shader(const char *v_path, const char *f_path) {
        unsigned int v_shader = compileShader(v_path, GL_VERTEX_SHADER);
        unsigned int f_shader = compileShader(f_path, GL_FRAGMENT_SHADER);
        id = glCreateProgram();
        glAttachShader(id, v_shader);
        glAttachShader(id, f_shader);
        glLinkProgram(id);
        glDeleteShader(v_shader);
        glDeleteShader(f_shader);
        if (!checkStatus(id, GL_PROGRAM)) {
            glDeleteProgram(id);
            return;
        }
        glValidateProgram(id);
    }
    ~Shader() {
        glDeleteProgram(id);
    }
    void use() {
        glUseProgram(id);
    }
    void setInt(const char *name, int value) {
        auto it = uniforms.find(name);
        if (it != uniforms.end()) {
            glUniform1i(it->second, value);
        } else {
            int loc = glGetUniformLocation(id, name);
            if (loc != -1) {
                uniforms[name] = loc;
            } else {
                std::cerr << "Can't find location " << name << '\n';
            }
        }
    }

    void setMat4(const char *name, glm::mat4 value) {
        auto it = uniforms.find(name);
        if (it != uniforms.end()) {
            glUniformMatrix4fv(it->second, 1, GL_FALSE, &value[0][0]);
        } else {
            int loc = glGetUniformLocation(id, name);
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
            unsigned int shader = glCreateShader(type);
            glShaderSource(shader, 1, &buf, NULL);
            glCompileShader(shader);
            if (!checkStatus(shader, type)) {
                glDeleteShader(shader);
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
            glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
            if (res == GL_FALSE) {
                int len;
                glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
                char *err_msg = new char[len];
                glGetShaderInfoLog(shader, len, &len, err_msg);
                std::cerr << "Compile " << (type == GL_VERTEX_SHADER ? "vertex" : "fragment") << "shader failed: "
                    << err_msg << '\n';
                delete [] err_msg;
                return false;
            }
        } else if (type == GL_PROGRAM) {
            int res;
            glGetProgramiv(shader, GL_LINK_STATUS, &res);
            if (res == GL_FALSE) {
                int len;
                glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len);
                char *err_msg = new char[len];
                glGetProgramInfoLog(shader, len, &len, err_msg);
                std::cerr << "Link program failed: " << err_msg << '\n';
                delete [] err_msg;
                return false;
            }
        }
        return true;
    }
};

#endif //SHADER_HPP
