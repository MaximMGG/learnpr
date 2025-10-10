#include <stdio.h>
#include <stdlib.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>


#define WIDTH 720
#define HEIGHT 480


u32 load_shader(str shader_name, u32 type) {
    reader *r = reader_create_from_file(shader_name);
    i8 *buf = alloc_copy(r->buf, r->bytes_availeble);

    u32 shader = glCreateShader(type);
    glShaderSource(shader, 1, (const char *const *)&buf, null);
    glCompileShader(shader);

    i32 success;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (success == GL_FALSE) {
        log(ERROR, "Compilation shader failed");
        dealloc(buf);
        reader_destroy(r);
        return 0;
    }

    dealloc(buf);
    reader_destroy(r);

    return shader;
}



int main() {
    glfwInit();
    log(INFO, "Init glfw");

    glfwWindowHint(GLFW_DOUBLEBUFFER, 1);
    glfwWindowHint(GLFW_DEPTH_BITS, 24);

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "Chess", null, null);
    if (window == null) {
        log(ERROR, "glfwCreateWindow failed");
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(window);

    if (glewInit() != 0) {
        log(ERROR, "glewInit failed");
        glfwDestroyWindow(window);
        glfwTerminate();
        return 1;
    }

    log(INFO, "glewInit");

    //glViewport(0, 0, WIDTH, HEIGHT);


    u32 v_shader = load_shader("vertex.glsl", GL_VERTEX_SHADER);
    u32 f_shader = load_shader("fragment.glsl", GL_FRAGMENT_SHADER);
    u32 program = glCreateProgram();
    glAttachShader(program, v_shader);
    glAttachShader(program, f_shader);
    glLinkProgram(program);

    glUseProgram(program);

    u32 VAO, VBO, IBO;

    f32 vertices[] = {
        -0.5f, -0.5f, 0.0f,
        -0.5f,  0.5f, 0.0f,
         0.5f,  0.5f, 0.0f,
         0.5f, -0.5f, 0.0f,
    };

    u32 indeces[] = {
        0, 1, 2, 2, 3, 0
    };

    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);

    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glGenBuffers(1, &IBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, IBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indeces), indeces, GL_STATIC_DRAW);

    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(f32) * 3, (void *)0);



    log(INFO, "Start main loop");

    while(!glfwWindowShouldClose(window)) {
        glClearColor(0.2f, 0.3f, 0.8f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null);

        glfwSwapBuffers(window);
        glfwPollEvents();

        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            glfwSetWindowShouldClose(window, true);
        }
    }


    glfwDestroyWindow(window);
    glfwTerminate();

    log(INFO, "End");
    return 0;
}
