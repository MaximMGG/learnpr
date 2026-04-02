#include <iostream>
#include <fstream>
#include <GL/glew.h>
#include <GLFW/glfw3.h>


unsigned int compileShader(const char *path, unsigned int type) {
    std::fstream file(path);
    if (file.is_open()) {
        file.seekg(0, std::ios::end);
        long file_size = file.tellg();
        file.seekg(0, std::ios::beg);
        char *buf = new char[file_size];
        file.read(buf, file_size);
        unsigned int shader = glCreateShader(type);
        glShaderSource(shader, 1, &buf, NULL);
        glCompileShader(shader);
        int res;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
        delete [] buf;
        if (res == GL_FALSE) {
            int len;
            glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
            char *err_msg = new char[len];
            glGetShaderInfoLog(shader, len, &len, err_msg);
            std::cerr << "Compile " << (type == GL_VERTEX_SHADER ? "vertex" : "fragment") << 
                "shader error: " << err_msg << '\n';
            delete [] err_msg;
            glDeleteShader(shader);
            return 0;
        }
        return shader;
    }

    return 0;
}


int main() {
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(1280, 720, "test", NULL, NULL);

    glfwMakeContextCurrent(window);

    if (glewInit() != 4) {
        std::cerr << "glewInit failed\n";
        return 1;
    }


    float vertices[] = {
        0.5, 0.5,
        0.5, -0.5,
        -0.5, -0.5,
        -0.5, 0.5,
    };
    unsigned int indecies[] = {
        0, 1, 2, 2, 3, 0
    };

    unsigned int VAO, VBO, EBO;
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);

    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 2, (void *)0);
    glEnableVertexAttribArray(0);

    unsigned int vertex = compileShader("./vertex.glsl", GL_VERTEX_SHADER);
    unsigned int fragment = compileShader("./fragment.glsl", GL_FRAGMENT_SHADER);
    unsigned int prog = glCreateProgram();
    glAttachShader(prog, vertex);
    glAttachShader(prog, fragment);
    glLinkProgram(prog);
    glValidateProgram(prog);

    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        glUseProgram(prog);
        glUniform4f(glGetUniformLocation(prog, "aColor"), 0.2, 0.4, 0.1, 1.0);

        glBindVertexArray(VAO);

        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, NULL);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}
