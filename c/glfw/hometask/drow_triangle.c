#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>

#define WIDTH 720
#define HEIGHT 480


i8 *shader_data(const str file_name) {
    reader *r = reader_create_from_file(file_name);
    i8 *shader = alloc_copy(r->buf, r->bytes_availeble + 1);
    reader_destroy(r);
    printf("%s\n", shader);
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

    u32 VAO; // vertex array object
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    log(INFO, "Bind vertex arrats");


    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    log(INFO, "gl attrib pointer done");


    i8 *vertexShaderSource = shader_data("./vertex.glsl");
    u32 vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, (const GLchar * const *)&vertexShaderSource, null);
    glCompileShader(vertexShader);
    i32 success;
    byte *err_buf;
    i32 err_buf_len;
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
    if (success == GL_FALSE) {
        glGetShaderiv(vertexShader, GL_INFO_LOG_LENGTH, &err_buf_len);
        err_buf = alloc(err_buf_len + 1);
        glGetShaderInfoLog(vertexShader, err_buf_len, NULL, err_buf);
        log(ERROR, "Shader compilation faild\n%s", err_buf);
        dealloc(err_buf);
        goto fatal_error;
    }

    log(INFO, "Load vertex shader");

    i8 *fragmentShaderSource = shader_data("./fragment.glsl");
    u32 fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, (const GLchar *const *)&fragmentShaderSource, null);
    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
    if (success == GL_FALSE) {
        glGetShaderiv(fragmentShader, GL_INFO_LOG_LENGTH, &err_buf_len);
        err_buf = alloc(err_buf_len + 1);
        glGetShaderInfoLog(fragmentShader, err_buf_len, NULL, err_buf);
        log(ERROR, "Shader compilation failed: %s\n", err_buf);
        dealloc(err_buf);
        goto fatal_error;
    }

    log(INFO, "Load fragment shader");
    u32 program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);

    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &err_buf_len);
        err_buf = alloc(err_buf_len + 1);
        glGetProgramInfoLog(program, err_buf_len, null, err_buf);
        log(ERROR, "Program linking fail\n%s", err_buf);
        dealloc(err_buf);
        goto fatal_error;
    }
    glUseProgram(program);
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    log(INFO, "Use pogram");
    dealloc(vertexShaderSource);
    dealloc(fragmentShaderSource);


    log(INFO, "Start cycle");

    while(!glfwWindowShouldClose(window)) {
        //set standard OpenGL backgroud color
        glClearColor(0.2, 0.3, 0.4, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);

        glUseProgram(program);
        glBindVertexArray(VAO);
        glDrawArrays(GL_TRIANGLES, 0, 3);


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

