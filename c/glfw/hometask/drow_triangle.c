#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>

#define WIDTH 720
#define HEIGHT 480


u8 *shader_data(const str file_name) {
    reader *r = reader_create_from_file(file_name);
    u8 *shader = alloc_copy(r->buf, r->bytes_availeble);
    reader_destroy(r);
    return shader;
}


int main() {
    log(INFO, "Initialize GLFW");
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "home task window", null, null);
    if (window == null) {
        log(FATAL, "Can't create glfw window");
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(window);
    log(INFO, "Set current context");

    if (glewInit() != 0) {
        log(FATAL, "Can't initialize OpenGL");
        goto fatal_error;
    }

    glViewport(0, 0, WIDTH, HEIGHT);
    log(INFO, "set viewport");


    f32 pos[] = {
        -0.5f, -0.5f,
         0.5f, -0.5f,
         0.0f,  0.5f
    };

    u32 index[] = {0, 1, 2};

    u32 VBO; // vertex buffer objects
    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(pos), pos, GL_STATIC_DRAW);
    log(INFO, "Gen VBO");

    u32 IBO;
    glGenBuffers(1, &IBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, IBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(index), index, GL_STATIC_DRAW);
    log(INFO, "Gen IBO");

    u32 VAO;



    u8 *vertexShaderSource = shader_data("vertex.glsl");
    u32 vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, (const GLchar * const *)vertexShaderSource, null);
    glCompileShader(vertexShader);
    i32 success;
    i8 buf[512];
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(vertexShader, 512, NULL, buf);
        log(ERROR, "Shader compilation faild\n%s", buf);
        goto fatal_error;
    }
    u8 *fragmentShaderSource = shader_data("fragment.glsl");
    u32 fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, (const GL))






    log(INFO, "Start cycle");

    while(!glfwWindowShouldClose(window)) {
        //set standard OpenGL backgroud color
        glClearColor(0.2, 0.3, 0.4, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);



        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    log(INFO, "End cycle");

exit_success:
    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;


fatal_error:
    glfwDestroyWindow(window);
    glfwTerminate();
    return 1;
}

