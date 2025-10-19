#include <iostream>
#include <fstream>
#include <unistd.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>

#define WIDTH 1280
#define HEIGHT 720



unsigned int compile_shader(unsigned int type, const char *source) {
    std::cout << "Prepare to compile shader: " << source << '\n';
    unsigned int shader = glCreateShader(type);
    glShaderSource(shader, 1, &source, NULL);
    glCompileShader(shader);

    int res;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
    if (res == GL_FALSE) {
        int len;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
        char *msg = new char [len];
        glGetShaderInfoLog(shader, len, &len, msg);
        std::cerr << "Compile " << (type == GL_VERTEX_SHADER ? "vertex" : "fragment") << " shader failed: " << msg << '\n';
        delete [] msg;
        glDeleteShader(shader);
        return 0;
    }
    return shader;
}


unsigned int compile_program(const char *vertex_path, const char *fragment_path) {
    std::ifstream s(vertex_path);
    s.seekg(0, std::ios::end);
    long file_size = s.tellg();
    s.seekg(0, std::ios::beg);
    char *buf = new char[file_size];
    s.read(buf, file_size);
    unsigned int vertex_shader = compile_shader(GL_VERTEX_SHADER, buf);
    delete []buf;
    s.close();

    std::ifstream s2(fragment_path);
    s2.seekg(0, std::ios::end);
    file_size = s2.tellg();
    buf = new char[file_size];
    s2.seekg(0, std::ios::beg);
    s2.read(buf, file_size);
    unsigned int fragment_shader = compile_shader(GL_FRAGMENT_SHADER, buf);
    delete [] buf;
    s2.close();

    unsigned int prog = glCreateProgram();
    glAttachShader(prog, vertex_shader);
    glAttachShader(prog, fragment_shader);
    glLinkProgram(prog);
    int res;
    glGetProgramiv(prog, GL_LINK_STATUS, &res);

    if (res == GL_FALSE) {
        int len;
        glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &len);
        char *msg = new char [len];
        glGetProgramInfoLog(prog, len, &len, msg);
        std::cerr << "Link program faled: " << msg << '\n';
        delete []msg;
        glDeleteProgram(prog);
        glDeleteShader(vertex_shader);
        glDeleteShader(fragment_shader);
        return 0;
    }

    glValidateProgram(prog);
    glDeleteShader(vertex_shader);
    glDeleteShader(fragment_shader);

    return prog;
}


int main() {
    std::cout << "Init task app\n";
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Task window", NULL, NULL);
    if (window == NULL) {
        std::cerr << "glfwCreateWindow error\n";
        glfwTerminate();
    }

    glfwMakeContextCurrent(window);

    if (glewInit() != 0) {
        std::cerr << "glewInit error\n";
        glfwTerminate();
    }

    float position[] = {
        0.5,  0.5,
        0.5, -0.5,
       -0.5, -0.5,
       -0.5,  0.5,
    };

    unsigned int indeces[] = {
        0, 1, 2, 2, 3, 0
    };

    unsigned int VBO, VAO, IBO;

    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);

    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(position), position, GL_STATIC_DRAW);

    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 2, (void *)0);

    glGenBuffers(1, &IBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, IBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indeces), indeces, GL_STATIC_DRAW);

    unsigned int prog = compile_program("./vertex.glsl", "./fragment.glsl");
    glUseProgram(prog);

    float inc = 0.05;
    float r = 0.4f;
    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        glUniform4f(glGetUniformLocation(prog, "u_Color"), r, 0.5, 0.6, 1.0);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);

        if (r > 1.0) {
            inc = -0.05;
        } else if (r < 0.0) {
            inc = 0.05;
        }

        r += inc;

        glfwSwapBuffers(window);
        glfwPollEvents();

        usleep(40000);
    }


    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
