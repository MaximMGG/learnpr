#include "../headers/config.h"
#include "../headers/triangle_mesh.h"
#include <GLFW/glfw3.h>

#define WIDTH 640
#define HEIGHT 480

unsigned int make_module(const std::string& filepath, unsigned int module_type);
unsigned int make_shader(const std::string& vertex_filepath, const std::string& fragment_filepath);


int main() {


    GLFWwindow *window;

    if (!glfwInit()) {
        std::cerr << "glfw can't be init\n";
        return 1;
    }


    // glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    // glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    // glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    // glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE);



    window = glfwCreateWindow(WIDTH, HEIGHT, "My super window", NULL, NULL);
    glfwMakeContextCurrent(window);


    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cerr << "GL can't start\n";
        glfwTerminate();
        return 1;
    }

    std::cout << "Window init\n";

    glClearColor(0.25f, 0.5f, 0.75f, 1.0f);

    int w, h;
    // glfwGetFramebufferSize(window, &w, &h);
    // std::cout << "widnow size : " << w << " " << h << '\n';



    TriangleMesh *triangle = new TriangleMesh();


    unsigned int shader = make_shader(
            "./src/shaders/vertex.txt",
            "./src/shaders/fragment.txt"
            );

    int last_w{}, last_h{};
    while(!glfwWindowShouldClose(window)) {
        glfwPollEvents();

        glfwGetFramebufferSize(window, &w, &h);

        if (last_w != w || last_h != h) {
            last_w = w; 
            last_h = h;
            std::cout << "Width : " << w << " height : " << h << '\n';
        }

        glViewport(0, 0, w, h);


        glClear(GL_COLOR_BUFFER_BIT);
        glUseProgram(shader);

        triangle->draw();


        glfwSwapBuffers(window);

    }

    glDeleteProgram(shader);
    delete triangle;
    glfwTerminate();
    std::cout << "Terminated\n";

    return 0;
}


unsigned int make_shader(const std::string& vertex_filepath, const std::string& fragment_filepath) {
    std::vector<unsigned int> modules;

    modules.push_back(make_module(vertex_filepath, GL_VERTEX_SHADER));
    modules.push_back(make_module(fragment_filepath, GL_FRAGMENT_SHADER));

    unsigned int shader = glCreateProgram();
    for(unsigned int shaderModule : modules) {
        glAttachShader(shader, shaderModule);
    }
    glLinkProgram(shader);


    //check the linking
    int success{};
    glGetProgramiv(shader, GL_LINK_STATUS, &success);
    if (!success) {
        char errorLog[1024];
        glGetProgramInfoLog(shader, 1024, NULL, errorLog);
        std::cout << "Program linking got error:\n" << errorLog << '\n';
    }

    for(unsigned int shaderModule : modules) {
        glDeleteShader(shaderModule);
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

    // std::cout << shaderSource << '\n';

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
    }

    return shaderModule;
}
