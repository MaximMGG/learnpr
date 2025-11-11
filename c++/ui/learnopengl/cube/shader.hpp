#ifndef SHADER_HPP
#define SHADER_HPP

#include <fstream>
#include <iostream>
#include <GL/glew.h>
#include <glm/glm.hpp>

class Shader {
public:
    unsigned int id = 0;
    Shader(const char *vertex_path, const char *fragment_path) {
        unsigned int vertex_shader = shaderCompile(vertex_path, GL_VERTEX_SHADER);
        unsigned int fragment_shader = shaderCompile(fragment_path, GL_FRAGMENT_SHADER);
        if (vertex_shader == 0 || fragment_shader == 0) {
            std::cout << "Shader creation error\n";
            return;
        }
        id = glCreateProgram();
        glAttachShader(id, vertex_shader);
        glAttachShader(id, fragment_shader);
        glLinkProgram(id);
        glDeleteShader(vertex_shader);
        glDeleteShader(fragment_shader);
        if (!checkStatus(id, GL_PROGRAM)) {
            std::cerr << "Program creation error\n";
            glDeleteProgram(id);
            id = 0;
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
        int loc = glGetUniformLocation(id, name);
        if (loc != -1) {
            glUniform1i(loc, value);
        }
    }

    void setMat4(const char *name, glm::mat4 val) {
        int loc = glGetUniformLocation(id, name);
        if (loc != -1) {
            glUniformMatrix4fv(loc, 1, GL_FALSE, &val[0][0]);
        }
    }


private:

    char *getFileContent(const char *shader_path) {
        std::ifstream file(shader_path);
        if (file.is_open()) {

        } else {
            std::cerr << "Cant open file: " << shader_path << '\n';
            return 0;
        }
        file.seekg(0, std::ios::end);
        long file_size = file.tellg();
        file.seekg(0, std::ios::beg);
        char *buf = new char [file_size];
        file.read(buf, file_size);
        file.close();

        return buf;
    }

    unsigned int shaderCompile(const char *shader_path, unsigned int shader_type) {
        char *source = getFileContent(shader_path);
        unsigned int shader = glCreateShader(shader_type);
        glShaderSource(shader, 1, &source, NULL);
        glCompileShader(shader);
        if (!checkStatus(shader, shader_type)) {
            std::cerr << "Error\n";
            return 0;
        }

        return shader;
    }

    bool checkStatus(unsigned int shader, unsigned int shader_type) {
        switch(shader_type) {
            case GL_VERTEX_SHADER:
            case GL_FRAGMENT_SHADER: {
                int res;
                glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
                if (res == GL_FALSE) {
                    int len;
                    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
                    char *err_msg = new char [len];
                    std::cout << "Error while compile shader: " << (shader_type == GL_VERTEX_SHADER ? "vertex" : "fragment") 
                        << " - " << err_msg << '\n';
                    delete [] err_msg;
                    return false;
                }
            } break;
            case GL_PROGRAM: {
                int res;
                glGetProgramiv(shader, GL_LINK_STATUS, &res);
                if (res == GL_FALSE) {
                    int len;
                    glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &len);
                    char *err_msg = new char [len];
                    std::cout << "Error while link program: " << err_msg << '\n';
                    delete [] err_msg;
                    return false;
                }
            } break;
            default: {
                         return true;
                     }
        }
        return true;
    }

};
#endif
