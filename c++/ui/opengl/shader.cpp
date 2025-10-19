#include "shader.hpp"
#include <GL/glew.h>

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#define u32 unsigned int

Shader::Shader(std::string &filepath) {
    ShaderProgramSource source = parseShader(filepath);
    this->rendererID = createShader(source.vertexShader, source.fragmentShader);
}

Shader::~Shader() {
    glDeleteProgram(this->rendererID);
}

void Shader::bind() {
    glUseProgram(this->rendererID);
}
void Shader::unbind() {
    glUseProgram(0);
}

void Shader::setUniform1i(const std::string &name, int v) {
    glUniform1i(getUniformLocation(name), v);
}

void Shader::setUniform1f(const std::string &name, float v) {
    glUniform1f(getUniformLocation(name), v);

}

void Shader::setUniformf4(const std::string &name, float v0, float v1, float v2, float v3) {
    glUniform4f(getUniformLocation(name), v0, v1, v2, v3);
}

void Shader::setUniformMatf4(const std::string &name, glm::mat4 &m) {
    glUniformMatrix4fv(getUniformLocation(name), 1, GL_FALSE, m);

}
    
ShaderProgramSource Shader::parseShader(const std::string &filepath) {
    std::ifstream s(filepath);
    std::string line;
    int pos = 0;
    std::stringstream ss[2];
    while(std::getline(s, line)) {
        if (line.find("#shader") != std::string::npos) {
            if (line.find("vertex") != std::string::npos) {
                pos = 0;
            } else if (line.find("fragment") != std::string::npos) {
                pos = 1;
            }
        } else {
            ss[pos] << line << '\n';
        }
    }
    s.close();

    return {ss[0].str(), ss[1].str()};
}

u32 Shader::compileShader(u32 type, const std::string &source) {
    u32 id = glCreateShader(type);
    const char *src = source.c_str();
    glShaderSource(id, 1, &src, NULL);
    glCompileShader(id);

    int res;
    glGetShaderiv(id, GL_COMPILE_STATUS, &res);
    if (res == GL_FALSE) {
        int len;
        glGetShaderiv(id, GL_INFO_LOG_LENGTH, &len);
        char *message = new char [len];
        glGetShaderInfoLog(id, len, &len, message);
        std::cout << "Failed to compile " << (type == GL_VERTEX_SHADER ? "vertex" : "fragment") << " shader: " << message << '\n';
        delete []message;
        glDeleteShader(id);
    }
    return id;
}

u32 Shader::createShader(const std::string &vertexShader, const std::string &fragmentShader) {
    u32 vs = compileShader(GL_VERTEX_SHADER, vertexShader);
    u32 fs = compileShader(GL_FRAGMENT_SHADER, fragmentShader);
    u32 program = glCreateProgram();
    glAttachShader(program, vs);
    glAttachShader(program, fs);
    glLinkProgram(program);
    glValidateProgram(program);

    glDeleteShader(vs);
    glDeleteShader(fs);
    return program;
}

int Shader::getUniformLocation(const std::string &name) {
    auto kv = this->uniformLocationCache.find(name);
    if (kv != this->uniformLocationCache.end()) {
        return kv->second;
    } else {
        int loc = glGetUniformLocation(this->rendererID, name.c_str());
        if (loc != -1) {
            this->uniformLocationCache[name] = loc;
        }
    }

    return glGetUniformLocation(this->rendererID, name.c_str());
}
