#include <GL/glew.h>
#include <GLFW/glfw3.h>
#define STB_IMAGE_IMPLEMENTATION
#include <stb/stb_image.h>
#include <iostream>


void compileShader(unsigned int shader) {
    glCompileShader(shader);
    int res;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
    if (res == GL_FALSE) {
        int len;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
        char *err_msg = new char [len];
        glGetShaderInfoLog(shader, len, &len, err_msg);
        std::cerr << "Compile shader error: " << err_msg << '\n';
        delete [] err_msg;
    }
}

const char *vertexSource = R"(
#version 330 core
layout (location = 0) in vec2 aPos;
layout (location = 1) in vec2 aTexCoord;

out vec2 TexCoord;

void main() {
    gl_Position = vec4(aPos.x, aPos.y, 0.0, 1.0);
    TexCoord = aTexCoord;
}

)";

const char *fragmentSource = R"(
#version 330 core

out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D texture1;

void main() {
    FragColor = texture(texture1, TexCoord);
}
)";

int main() {


    float vertices[] = {
        -0.5f, -0.5f, 0.0f, 0.0f,
         0.5f, -0.5f, 1.0f, 0.0f,
         0.5f,  0.5f, 1.0f, 1.0f,

         0.5f,  0.5f, 1.0f, 1.0f,
        -0.5f,  0.5f, 0.0f, 1.0f,
        -0.5f, -0.5f, 0.0f, 0.0f
    };


    glfwInit();


    const GLFWvidmode *vm = glfwGetVideoMode(glfwGetPrimaryMonitor());

    const int screenWidth = vm->width;
    const int screenHeight = vm->height;

    const int windowWidth = screenHeight / 2;
    const int windowHeight = screenHeight / 2;

    GLFWwindow *window = glfwCreateWindow(windowWidth, windowHeight, "CUBE", NULL, NULL);
    if (window == NULL) {
        std::cout << "Failed to create GLFW window\n";
        glfwTerminate();
        return 1;
    }


    int windowPosX = (screenWidth - windowWidth) / 2;
    int windowPosY = (screenHeight - windowHeight) / 2;

    glfwSetWindowAspectRatio(window, 1, 1);
    glfwMakeContextCurrent(window);

    if (glewInit() != 0) {
        std::cerr << "Failed to initialize GLEW\n";
        glfwTerminate();
        return 1;
    }

    unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexSource, NULL);
    compileShader(vertexShader);
    unsigned int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentSource, NULL);
    compileShader(fragmentShader);

    unsigned int prog = glCreateProgram();
    glAttachShader(prog, vertexShader);
    glAttachShader(prog, fragmentShader);
    glLinkProgram(prog);
    int res;
    glGetProgramiv(prog, GL_LINK_STATUS, &res);
    if (res == GL_FALSE) {
        std::cout << "glLinkProgram failed\n";
        glDeleteProgram(prog);
        glfwTerminate();
    }
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    unsigned int VAO, VBO;

    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);

    glBindVertexArray(VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 4, (void *)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 4, (void *)(sizeof(float) * 2));
    glEnableVertexAttribArray(1);


    unsigned int texture ;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);


    int textureWidth, textureHeight, nrChannels;
    stbi_set_flip_vertically_on_load(true);

    unsigned char *data = stbi_load("./crate.png", &textureWidth, &textureHeight, &nrChannels, 0);
    if (data) {
        int format = nrChannels == 4 ? GL_RGBA : GL_RGB;
        glTexImage2D(GL_TEXTURE_2D, 0, format, textureWidth, textureHeight, 0, format, GL_UNSIGNED_BYTE, data);
    } else {
        std::cerr << "Failed to load image\n";
    }

    stbi_image_free(data);

    glUseProgram(prog);
    glUniform1i(glGetUniformLocation(prog, "texture1"), 0);

    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

    while(!glfwWindowShouldClose(window)) {

        int fbWidth, fbHeight;
        glfwGetFramebufferSize(window, &fbWidth, &fbHeight);
        glViewport(0, 0, fbWidth, fbHeight);

        glClear(GL_COLOR_BUFFER_BIT);
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture);

        glUseProgram(prog);
        glBindVertexArray(VAO);

        glDrawArrays(GL_TRIANGLES, 0, 6);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }


    glDeleteProgram(prog);
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteTextures(1, &texture);

    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
