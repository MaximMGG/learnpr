#include <iostream>
#include <fstream>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>

#define WIDTH 1280
#define HEIGHT 720

unsigned int load_shader(const char *path, unsigned int type) {
    std::ifstream file(path);
    file.seekg(0, std::ios::end);
    long file_size = file.tellg();
    file.seekg(0, std::ios::beg);
    char *buf = new char [file_size];
    file.read(buf, file_size);

    std::cout << "Shader:\n" << buf << '\n';

    unsigned int shader = glCreateShader(type);
    glShaderSource(shader, 1, &buf, NULL);
    glCompileShader(shader);

    int res;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
    if (res == GL_FALSE) {
        int len;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
        char *err_msg = new char [len];
        glGetShaderInfoLog(shader, len, &len, err_msg);
        std::cout << "Compile shader " << (type == GL_VERTEX_SHADER ? "vertex" : "fragment") << " " << err_msg << '\n';
        glDeleteShader(shader);
        delete [] err_msg;
        return 0;
    }
    file.close();
    delete [] buf;
    return shader;
}


int main() {
    std::cout << "Init\n";
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Window", NULL, NULL);
    if (window == NULL) {
        std::cerr << "glfwCreateWindow failed\n";
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(window);

    if (glewInit() != 0) {
        std::cerr << "glewInit failed\n";
    }


    float verteces[] = {
        0.5f,  0.5f,
        0.5f, -0.5f,
       -0.5f, -0.5f,
       -0.5f,  0.5f
    };

    unsigned int indeces[] = {
        0, 1, 2, 2, 3, 0
    };

    unsigned int VBO, EBO, VAO;

    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verteces), verteces, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indeces), indeces, GL_STATIC_DRAW);


    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);

    glBindBuffer(GL_ARRAY_BUFFER, 0);

    glBindVertexArray(0);

    unsigned int v_shader = load_shader("./vertex.glsl", GL_VERTEX_SHADER);
    unsigned int f_shader = load_shader("./fragment.glsl", GL_FRAGMENT_SHADER);
    if (v_shader == 0 || f_shader == 0) {
        std::cerr << "Compile shader failed\n";
        return 1;
    }
    unsigned int program = glCreateProgram();
    glAttachShader(program, v_shader);
    glAttachShader(program, f_shader);
    glLinkProgram(program);
    int res;
    glGetProgramiv(program, GL_LINK_STATUS, &res);
    if (res == GL_FALSE) {
        int len;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &len);
        char *err_msg = new char[len];
        glGetProgramInfoLog(program, len, &len, err_msg);
        std::cerr << "Program link failed " << err_msg << '\n';
        delete [] err_msg;
        glDeleteProgram(program);
        return 1;
    }
    glValidateProgram(program);
    glDeleteShader(v_shader);
    glDeleteShader(f_shader);
    glUseProgram(program);

    std::cout << "Main loop start\n";
    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        glUniform4f(glGetUniformLocation(program, "uColor"), 0.2, 0.3, 0.4, 1.0);
        glBindVertexArray(VAO);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }



    glfwDestroyWindow(window);
    glfwTerminate();

    std::cout << "End\n";
    return 0;
}

