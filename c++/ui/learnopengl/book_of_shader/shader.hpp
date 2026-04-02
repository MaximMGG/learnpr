#ifndef SHADER_HPP
#define SHADER_HPP
#include <fstream>
#include <iostream>
#include <GL/glew.h>
#include <glm/glm.hpp>

class Shader {
public:
    unsigned int id;

    Shader(const char *v_path, const char *f_path) {
        unsigned int v_shader = compileShader(v_path, GL_VERTEX_SHADER);
        unsigned int f_shader = compileShader(f_path, GL_FRAGMENT_SHADER);
        id = glCreateProgram();
        glAttachShader(id, v_shader);
        glAttachShader(id, f_shader);
        glLinkProgram(id);
        if (!checkStatus(id, GL_PROGRAM)) {
            glDeleteShader(v_shader);
            glDeleteShader(f_shader);
            glDeleteProgram(id);
            return;
        }
        glValidateProgram(id);
        glDeleteShader(v_shader);
        glDeleteShader(f_shader);
    }

    ~Shader() {
        glDeleteProgram(id);
    }

    void use() {
        glUseProgram(id);
    }

    void setFloat(const char *name, float value) {
        int loc = glGetUniformLocation(id, name);
        if (loc != -1) {
            glUniform1f(loc, value);
        } else {
            std::cerr << "Cant find location: " << loc << '\n';
        }
    }
    void setVec2(const char *name, glm::vec2 value) {
        int loc = glGetUniformLocation(id, name);
        if (loc != -1) {
            glUniform2fv(loc, 1, &value[0]);
        } else {
            std::cerr << "Cant find location: " << loc << '\n';
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
            delete [] buf;
            if (!checkStatus(shader, type)){
                glDeleteShader(shader);
                return 0;
            }
            return shader;
        } else {
            std::cerr << "Error while open file\n";
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
                std::cerr << "Error while compile " << (type == GL_VERTEX_SHADER ? "vertex" : "fragment") << " shader: " << err_msg << '\n';
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
                std::cerr << "Error while link " << " program: "<< err_msg << '\n';
                delete [] err_msg;
                return false;
            }
        }
        return true;
    }

};

#endif
