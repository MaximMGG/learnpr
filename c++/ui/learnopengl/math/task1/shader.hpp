#ifndef SHADER_HPP
#define SHADER_HPP
#include <GL/glew.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <fstream>
#include <iostream>

enum STATUS_TYPE {
    VERTEX_SHADER,
    FRAGMENT_SHADER,
    PROGRAM
};

class Shader {
public:
    unsigned int ID = 0;

    Shader(const char *v_path, const char *f_path) {
        const char *v_source = getSource(v_path);
        const char *f_source = getSource(f_path);

        unsigned int vertex =   glCreateShader(GL_VERTEX_SHADER);
        unsigned int fragment = glCreateShader(GL_FRAGMENT_SHADER);

        glShaderSource(vertex, 1, &v_source, NULL);
        glShaderSource(fragment, 1, &f_source, NULL);
        glCompileShader(vertex);
        if (!checkStatus(vertex, VERTEX_SHADER)) {
            return;
        }
        glCompileShader(fragment);
        if (!checkStatus(fragment, FRAGMENT_SHADER)) {
            return;
        }
        this->ID = glCreateProgram();
        glAttachShader(this->ID, vertex);
        glAttachShader(this->ID, fragment);
        glLinkProgram(this->ID);

        if (!checkStatus(this->ID, PROGRAM)) {
            return;
        }
        glValidateProgram(this->ID);
    }

    ~Shader() {
        glDeleteProgram(ID);
    }

    void use() {
        glUseProgram(ID);
    }

    void setInt(const char *name, int value) {

    }


    void set4f(const char *name, float v1, float v2, float v3, float v4) {
        int pos = glGetUniformLocation(ID, name);
        if (pos < 0) {
            std::cerr << "Can't find uniform: " << name << '\n';
        } else {
            glUniform4f(pos, v1, v2, v3, v4);
        }
    }


private:
    bool checkStatus(unsigned int shader, STATUS_TYPE type) {
        int res;
        if (type == PROGRAM) {
            glGetProgramiv(shader, GL_LINK_STATUS, &res);
            if (res == GL_FALSE) {
                int len;
                glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len);
                char *err = new char [len];
                glGetProgramInfoLog(shader, len, &len, err);
                std::cerr << "Link program error: " << err << '\n';
                delete [] err;
                return false;
            }
        } else {
            glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
            if (res == GL_FALSE) {
                int len;
                glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
                char *err = new char [len];
                glGetShaderInfoLog(shader, len, &len, err);
                std::cerr << "Compile shader " << (type == VERTEX_SHADER ? "vertex" : "fragment") 
                    <<  " failed: " << err << '\n';
                delete [] err;
                return false;
            }
        }
        return true;
    }

    char *getSource(const char *path) {
        std::ifstream file(path);
        if (file.is_open()) {
            file.seekg(0, std::ios::end);
            long file_size = file.tellg();
            file.seekg(0, std::ios::beg);
            char *buf = new char [file_size];
            file.read(buf, file_size);
            return buf;
        } else {
            std::cerr << "Can't open file: " << path << '\n';
            return NULL;
        }
        return NULL;
    }
};

#endif

