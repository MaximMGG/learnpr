#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <stdlib.h>


void framebuffer_size_callback(GLFWwindow *win, int width, int height) {
    glViewport(0, 0, width, height);
}

void processInput(GLFWwindow *win) {
    if (glfwGetKey(win, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(win, GLFW_TRUE);
    }
}

const char *vertexShaderSource = 
    "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
    "void main()\n"
    "{\n"
    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
    "}\0";

const char *fragmentShaderSource =
    "#version 330 core\n"
    "out vec4 FragColor;\n"
    "void main()\n"
    "{\n"
    "   FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
    "}\n\0";

const char *fragment2ShaderSource = 
    "#version 330 core\n"
    "out vec4 FragColor;\n"
    "void main()\n"
    "{\n"
    "   FragColor = vec4(1.123f, 0.4f, 0.9f, 1.0f);\n"
    "}\n\0";

int main() {

    if (!glfwInit()) {
        fprintf(stderr, "Cant init glfw\n");
        return EXIT_FAILURE;
    }

    GLFWwindow *win = glfwCreateWindow(1280, 720, "GFLW simple winfow", NULL, NULL);

    if (!win) {
        glfwTerminate();
        fprintf(stderr, "Cant create window gflw\n");
        return EXIT_FAILURE;
    }

    glfwMakeContextCurrent(win);
    glfwSetFramebufferSizeCallback(win, framebuffer_size_callback);

    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        fprintf(stderr, "Failed to initialize glad\n");
        return 1;
    }

    unsigned int vertexShader;
    vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
    glCompileShader(vertexShader);

    int success;
    char infoLog[512];
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
    if (!success) {
       glGetShaderInfoLog(vertexShader, 512, NULL, infoLog); 
       fprintf(stderr, "ERROR::SHADER::VERTEX::COMPILATION_FAILD\n%s\n", infoLog);
    }

    unsigned int fragmentShader;
    fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
    glCompileShader(fragmentShader);

    unsigned int fragment2Shader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragment2Shader, 1, &fragment2ShaderSource, NULL);
    glCompileShader(fragment2Shader);

    unsigned int shaderProgram = glCreateProgram();
    unsigned int shaderProgram2 = glCreateProgram();

    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);

    glAttachShader(shaderProgram2, vertexShader);
    glAttachShader(shaderProgram2, fragment2Shader);
    glLinkProgram(shaderProgram2);


    glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success); 

    if (!success) {
        glGetProgramInfoLog(shaderProgram, 512, NULL, infoLog);
        fprintf(stderr, "ERROR::SHADER::VERTEX::LINK_PROGRAM_FAILD\n%s\n", infoLog);
    }

    //glUseProgram(shaderProgram);

    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    float vertices[] = {
         0.5f,  0.5f, 0.0f,
         0.5f, -0.5f, 0.0f,
        -0.5f, -0.5f, 0.0f,
        -0.5f,  0.5f, 0.0f
    };

    float ver1[] = {
        0.5f, 0.7f, 0.0f,
        0.7f,-0.3f, 0.0f,
       -0.6f,-0.5f, 0.0f
    };

    unsigned int indices[] = {
        0, 1, 3,
        1, 2, 3
    };

    unsigned int ind2[] = {0, 1, 2};

    unsigned int VBO, VAO, EBO;
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);
    glGenVertexArrays(1, &VAO);


    unsigned int VBO2, VAO2, EBO2;
    glGenBuffers(1, &VBO2);
    glGenBuffers(1, &EBO2);
    glGenVertexArrays(1, &VAO2);



    glBindVertexArray(VAO);
    glBindVertexArray(VAO2);


    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);


    //
    glBindBuffer(GL_ARRAY_BUFFER, VBO2);
    glBufferData(GL_ARRAY_BUFFER, sizeof(ver1), ver1, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO2);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(ind2), ind2, GL_STATIC_DRAW);

    //
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);

    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);


    while(!glfwWindowShouldClose(win)) {
        processInput(win);


        glClearColor(0.2, 0.3, 0.3, 0.1);
        glClear(GL_COLOR_BUFFER_BIT);

        glUseProgram(shaderProgram);
    //    glBindVertexArray(VAO);
        glUseProgram(shaderProgram2);
        glBindVertexArray(VAO2);

        glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_INT, 0);

        glfwSwapBuffers(win);
        glfwPollEvents();
    }


    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);
    glDeleteProgram(shaderProgram);

    glfwDestroyWindow(win);
    glfwTerminate();

    return 0;
}
