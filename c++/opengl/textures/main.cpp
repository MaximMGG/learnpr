#include "stb_image.h"
#include <iostream>
#include <fstream>
#include <sys/stat.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>


#define WIDTH 720
#define HEIGHT 480

unsigned int load_tex(std::string tex_name) {

    stbi_set_flip_vertically_on_load(true);
    int width, height, nrChannels;
    unsigned char *data = stbi_load(tex_name.c_str(), &width, &height, &nrChannels, 0);

    unsigned int texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    if (data) {
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
    } else {
        std::cerr << "Failed to load texture\n";
    }

    stbi_image_free(data);
    return texture;
}

unsigned int load_shader(const char *shader_name, unsigned int type) {
    std::fstream f;
    f.open(shader_name);
    struct stat st;
    stat(shader_name, &st);
    char *buf = new char[st.st_size];
    f.read(buf, st.st_size);
    f.close();

    unsigned int shader =  glCreateShader(type);
    glShaderSource(shader, 1, &buf, NULL);
    glCompileShader(shader);
    int status;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
        int len;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
        char *err_buf = new char [len];
        glGetShaderInfoLog(shader, len, NULL, err_buf);
        std::cerr << "Compile shader fail: " << err_buf << '\n';
        delete [] err_buf;
        return 0;
    }

    delete [] buf;

    return shader;
}


int main() {
    std::cout << "Startup\n";

    glfwInit();
    std::cout << "Init glfw\n";

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Texture window", nullptr, nullptr);
    if (window == NULL) {
        std::cerr << "glfwCreateWindow error\n";
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(window);
    std::cout << "Make context\n";

    unsigned int texture = load_tex("wall.jpg");
    unsigned int vertexShader = load_shader("vertex.glsl", GL_VERTEX_SHADER);
    unsigned int fragmentShader = load_shader("fragment.glsl", GL_FRAGMENT_SHADER);
    unsigned int program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    glUseProgram(program);

    float vertices[] = {
        // positions          // colors           // texture coords
        0.5f,  0.5f, 0.0f,   1.0f, 0.0f, 0.0f,   1.0f, 1.0f,   // top right
        0.5f, -0.5f, 0.0f,   0.0f, 1.0f, 0.0f,   1.0f, 0.0f,   // bottom right
        -0.5f, -0.5f, 0.0f,   0.0f, 0.0f, 1.0f,   0.0f, 0.0f,   // bottom left
        -0.5f,  0.5f, 0.0f,   1.0f, 1.0f, 0.0f,   0.0f, 1.0f    // top left 
    };

    unsigned int VBO;
    unsigned int VAO;
    glGenBuffers(1, &VBO);
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, 3, vertices, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 8, (void *)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 8, (void *)(sizeof(float) * 3));
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, sizeof(float) * 8, (void *)(sizeof(float) * 6));
    glEnableVertexAttribArray(2);

    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        glBindTexture(GL_TEXTURE_2D, texture);
        glBindVertexArray(VAO);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }




    return 0;
}
