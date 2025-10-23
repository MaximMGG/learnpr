#include <GL/glew.h>
#include <fstream>
#include <iostream>
#include <string.h>
#include <glm/glm.hpp>


struct Shader {
    unsigned int ID;
    static char err_msg[1024];

    enum SHADER_TYPE {
        VERTEX_SHADER,
        FRAGMENT_SHADER,
        PROGRAM
    };

    Shader(const char *v_shader, const char *f_shader) {
        unsigned int vertex;
        unsigned int fragment;

        std::ifstream v_file(v_shader);
        if (v_file.is_open()) {
            v_file.seekg(0, std::ios::end);
            long file_size = v_file.tellg();
            v_file.seekg(0, std::ios::beg);
            char *v_source = new char[file_size];
            v_file.read(v_source, file_size);
            vertex = glCreateShader(GL_VERTEX_SHADER);
            glShaderSource(vertex, 1, &v_source, NULL);
            glCompileShader(vertex);
            if (!checkStatus(vertex, VERTEX_SHADER)) {
                std::cerr << "Compile vertex shader failed: " << err_msg << '\n';
                return;
            }
        } else {
            std::cerr << "Can't open file: " << v_shader << '\n';
            return;
        }
        std::ifstream f_file(f_shader);
        if (f_file.is_open()) {
            f_file.seekg(0, std::ios::end);
            long file_size = f_file.tellg();
            f_file.seekg(0, std::ios::beg);
            char *f_source = new char[file_size];
            f_file.read(f_source, file_size);
            fragment = glCreateShader(GL_VERTEX_SHADER);
            glShaderSource(fragment, 1, &f_source, NULL);
            glCompileShader(fragment);
            if (!checkStatus(fragment, FRAGMENT_SHADER)) {
                std::cerr << "Compile vertex shader failed: " << err_msg << '\n';
                return;
            }
        } else {
            std::cerr << "Can't open file: " << f_shader << '\n';
            return;
        }

        ID = glCreateProgram();
        glAttachShader(ID, vertex);
        glAttachShader(ID, fragment);
        glLinkProgram(ID);
        if (!checkStatus(ID, PROGRAM)) {
            std::cerr << "Link program failed: " << err_msg << '\n';
            return;
        }
        glValidateProgram(ID);
        glDeleteShader(vertex);
        glDeleteShader(fragment);
    }

    ~Shader() {
        glDeleteProgram(ID);
    }

    void use() {
        glUseProgram(ID);
    }


    bool checkStatus(unsigned int shader, SHADER_TYPE type) {
        if (type == PROGRAM) {
            int res;
            glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
            if (res == GL_FALSE) {
                memset(err_msg, 0, 1024);
                glGetShaderInfoLog(shader, 1024, NULL, err_msg);
                return false;
            }
        } else {
            int res;
            glGetProgramiv(shader, GL_LINK_STATUS, &res);
            if (res == GL_FALSE) {
                memset(err_msg, 0, 1024);
                glGetProgramInfoLog(shader, 1024, NULL, err_msg);
                return false;
            }
        }
        return true;
    }

    void setBool(const char *name, bool value) {
        glUniform1i(glGetUniformLocation(ID, name), (int)value);
    }
    void setInt(const char *name, int value) {
        glUniform1i(glGetUniformLocation(ID, name), value);
    }
    void setFloat(const char *name, float value) {
        glUniform1f(glGetUniformLocation(ID, name), value);
    }
    void setVec2(const char *name, glm::vec2 &value) {
        glUniform2fv(glGetUniformLocation(ID, name), 1, &value[0]);
    }
    void setVec2(const char *name, float x, float y) {
        glUniform2f(glGetUniformLocation(ID, name), x, y);
    }
    void setVec3(const char *name, glm::vec3 &value) {
        glUniform3fv(glGetUniformLocation(ID, name), 1, &value[0]);
    }
    void setVec3(const char *name, float x, float y, float z) {
        glUniform3f(glGetUniformLocation(ID, name), x, y, z);
    }
    void setVec4(const char *name, glm::vec4 &value) {
        glUniform4fv(glGetUniformLocation(ID, name), 1, &value[0]);
    }
    void setVec4(const char *name, float x, float y, float z, float w) {
        glUniform4f(glGetUniformLocation(ID, name), x, y, z, w);
    }
    void setMat2(const char *name, glm::mat2 &mat) {
        glUniformMatrix2fv(glGetUniformLocation(ID, name), 1, GL_FALSE, &mat[0][0]);
    }
    void setMat3(const char *name, glm::mat3 &mat) {
        glUniformMatrix3fv(glGetUniformLocation(ID, name), 1, GL_FALSE, &mat[0][0]);
    }
    void setMat4(const char *name, glm::mat4 &mat) {
        glUniformMatrix4fv(glGetUniformLocation(ID, name), 1, GL_FALSE, &mat[0][0]);
    }

};
