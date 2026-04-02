#include <stdio.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>
#include <unistd.h>


u32 load_shader(const str shader_name, u32 shader_type) {
    reader *r = reader_create_from_file(shader_name);
    u32 shader = glCreateShader(shader_type);
    glShaderSource(shader, 1, (const char * const *)&r->buf, null);
    glCompileShader(shader);
    i32 res;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &res);
    if (res == GL_FALSE) {
        i32 err_len;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &err_len);
        str buf = alloc(err_len + 1);
        glGetShaderInfoLog(shader, err_len, null, buf);
        log(ERROR, "Cant compile shader %s - %s", shader_name, buf);
        dealloc(buf);
    }
    
    reader_destroy(r);

    return shader;
}


#define WIDTH 720
#define HEIGHT 480

int main() {

    log(INFO, "Startup");
    glfwInit();
    log(INFO, "init glfw");

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Task window", null, null);
    if (window == null) {
        log(FATAL, "glfwCreateWindow error");
        glfwTerminate();
        return 1;
    }

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    glfwMakeContextCurrent(window);

    if (glewInit()) {
        log(FATAL, "glewInit error");
        goto fatal_error;
    }

    f32 pos1[] = {
        0.5f,  0.5f,
        0.5f, -0.5f,
       -0.5f, -0.5f
    };

    f32 pos2[] = {
       -0.5f, -0.5f,
       -0.5f,  0.5f,
        0.5f,  0.5f
    };

    u32 VBO1;
    u32 VBO2;

    glGenBuffers(1, &VBO1);
    glGenBuffers(1, &VBO2);

    u32 VAO1;
    u32 VAO2;

    glGenVertexArrays(1, &VAO1);
    glGenVertexArrays(1, &VAO2);

    glBindVertexArray(VAO1);
    glBindBuffer(GL_ARRAY_BUFFER, VBO1);
    glBufferData(GL_ARRAY_BUFFER, sizeof(pos1), pos1, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);

    glBindVertexArray(VAO2);
    glBindBuffer(GL_ARRAY_BUFFER, VBO2);
    glBufferData(GL_ARRAY_BUFFER, sizeof(pos2), pos2, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, (void *)0);
    glEnableVertexAttribArray(0);


    u32 vertexShader = load_shader("./vertex.glsl", GL_VERTEX_SHADER);
    u32 fragmentShader = load_shader("./fragment.glsl", GL_FRAGMENT_SHADER);

    u32 program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    glUseProgram(program);

    f32 r = 0.2f, l = 0.4f;
    f32 inc = 0.01;

    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);

        glUniform4f(glGetUniformLocation(program, "u_Color"), r, 0.1f, 0.4f, 1.0f);
        glBindVertexArray(VAO1);
        glDrawArrays(GL_TRIANGLES, 0, 3);


        glUniform4f(glGetUniformLocation(program, "u_Color"), l, 0.8f, 0.2f, 1.0f);
        glBindVertexArray(VAO2);
        glDrawArrays(GL_TRIANGLES, 0, 3);

        if (r > 1.0f && l > 1.0f) {
            inc = -0.05f;
        } else if (r < 0.0f && l < 0.0f) {
            inc = 0.05;
        }
        r += inc;
        l += inc;

        glfwSwapBuffers(window);
        glfwPollEvents();
        usleep(40000);
    }


    glfwDestroyWindow(window);
    glfwTerminate();
    log(INFO, "End prog");
    return 0;

fatal_error:
    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
