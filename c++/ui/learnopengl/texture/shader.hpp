#ifndef SHADER_H
#define SHADER_H

#include <GL/glew.h>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

struct Shader {
    unsigned int ID = 0;

    Shader(const char *vertexPath, const char *fragmentPath) {
        std::ifstream vertexFile(vertexPath);
        std::ifstream fragmentFile(fragmentPath);
        std::string vertexCode;
        std::string fragmentCode;

        std::stringstream vertexStream, fragmentStream;
        vertexStream << vertexFile.rdbuf();
        fragmentStream << fragmentFile.rdbuf();

        vertexCode = vertexStream.str();
        fragmentCode = fragmentStream.str();

        unsigned int vertex, fragment;

        vertex = glCreateShader(GL_VERTEX_SHADER);
        fragment = glCreateShader(GL_FRAGMENT_SHADER);

        const char *vShaderCode = vertexCode.c_str();
        const char *fShaderCode = fragmentCode.c_str();

        glShaderSource(vertex, 1, &vShaderCode, NULL);
        glCompileShader(vertex);
        if (!checkCompileError(vertex, "VERTEX")) {
            glDeleteShader(vertex);
            return;
        }
        glShaderSource(fragment, 1, &fShaderCode, NULL);
        glCompileShader(fragment);
        if (!checkCompileError(fragment, "FRAGMENT")) {
            glDeleteShader(fragment);
            return;
        }
        ID = glCreateProgram();

        glAttachShader(ID, vertex);
        glAttachShader(ID, fragment);
        glLinkProgram(ID);
        if (checkCompileError(ID, "PROGRAM")) {
            glDeleteProgram(ID);
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


    bool checkCompileError(unsigned int shader, const char *type) {
        int res;
        char infolog[1024]{};

        if (type[0] == 'P' || type[0] == 'p') {
            glGetProgramiv(shader, GL_LINK_STATUS, &res);
            if (!res) {
                glGetProgramInfoLog(shader, 1024, NULL, infolog);
                std::cerr << "Program linking error: " << infolog << '\n';
                return false;
            }
        } else {
            glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
            if (res == GL_FALSE) {
                glGetShaderInfoLog(shader, 1024, NULL, infolog);
                std::cerr << "Shader compilation error: " << type << " : " << infolog << '\n';
                return false;
            }
        }
        return true;
    }

    void set4f(const char *name, float v1, float v2, float v3, float v4) {
        glUniform4f(glGetUniformLocation(ID, name), v1, v2, v3, v4);
    }

};



#endif
