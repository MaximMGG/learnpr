#include "../headers/config.h"
#include <GLFW/glfw3.h>

#define WIDTH 640
#define HEIGHT 480

unsigned int make_module(const std::string& filepath, unsigned int module_type);
unsigned int make_shader(const std::string& vertex_filepath, const std::string& fragment_filepath);


int main() {

    std::ifstream file;
    //std::stringstream bufferLines;
    std::string line;


    file.open("./src/shaders/vertex.txt");
    while(std::getline(file, line)) {
        std::cout << line << '\n';
    }

    GLFWwindow *window;

    if (!glfwInit()) {
        std::cerr << "glfw can't be init\n";
        return 1;
    }

    window = glfwCreateWindow(WIDTH, HEIGHT, "My super window", NULL, NULL);
    glfwMakeContextCurrent(window);


    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cerr << "GL can't start\n";
        glfwTerminate();
        return 1;
    }

    std::cout << "Window init\n";



    glClearColor(0.25f, 0.5f, 0.75f, 1.0f);

    unsigned int shader = make_shader(
            "./src/shaders/vertex.txt",
            "./src/shaders/fragment.txt"
            );

    while(!glfwWindowShouldClose(window)) {
        glfwPollEvents();

        glClear(GL_COLOR_BUFFER_BIT);
        glUseProgram(shader);
        glfwSwapBuffers(window);

    }

    glDeleteProgram(shader);
    glfwTerminate();
    std::cout << "Terminated\n";

    return 0;
}


unsigned int make_shader(const std::string& vertex_filepath, const std::string& fragment_filepath) {
    std::vector<unsigned int> modules;

    modules.push_back(make_module(vertex_filepath, GL_VERTEX_SHADER));
    modules.push_back(make_module(fragment_filepath, GL_VERTEX_SHADER));

    unsigned int shader = glCreateProgram();
    for(unsigned int shaderModule : modules) {
        glAttachShader(shader, shaderModule);
    }
    glLinkProgram(shader);
    int success{};

    glGetProgramiv(shader, GL_LINK_STATUS, &success);
    if (!success) {
        char errorLog[1024];
        glGetProgramInfoLog(shader, 1024, NULL, errorLog);
        std::cout << "Program linking got error:\n" << errorLog << '\n';
        return 0;
    }

    return shader;

}


unsigned int make_module(const std::string& filepath, unsigned int module_type) {
    std::ifstream file;
    std::stringstream bufferLines;
    std::string line;

    file.open(filepath);
    while(std::getline(file, line)) {
        bufferLines << line << '\n';
    }
    std::string shaderSource = bufferLines.str();

    std::cout << shaderSource << '\n';

    const char *shaderSrc = shaderSource.c_str();
    bufferLines.str("");
    file.close();


    unsigned int shaderModule = glCreateShader(module_type);
    glShaderSource(shaderModule, 1, &shaderSrc, NULL);
    glCompileShader(shaderModule);

    int success{};
    glGetShaderiv(shaderModule, GL_COMPILE_STATUS, &success);
    if (!success) {
        char errorLog[1024];
        glGetShaderInfoLog(shaderModule, 1024, NULL, errorLog);
        std::cout << "Shader Module compilation error:\n" << errorLog << '\n';
        return 0;
    }

    return shaderModule;
}
