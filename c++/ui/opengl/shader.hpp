#ifndef SHADER_HPP
#define SHADER_HPP
#include <unordered_map>
#include <string>
#include <glm/glm.hpp>

#define u32 unsigned int

struct ShaderProgramSource {
    std::string vertexShader;
    std::string fragmentShader;
};

struct Shader {
    u32 rendererID;
    std::unordered_map<std::string, int> uniformLocationCache;

    Shader(std::string &filepath);
    ~Shader();

    void bind();
    void unbind();

    void setUniform1i(const std::string &name, int value);
    void setUniform1f(const std::string &name, float value);
    void setUniformf4(const std::string &name, float v0, float v1, float v2, float v3);
    void setUniformMatf4(const std::string &name, glm::mat4 &m);
    
private:
    ShaderProgramSource parseShader(const std::string &filepath);
    u32 compileShader(u32 type, const std::string &source);
    u32 createShader(const std::string &vertexShader, const std::string &fragmentShader);
    int getUniformLocation(const std::string &name);

};


#endif
