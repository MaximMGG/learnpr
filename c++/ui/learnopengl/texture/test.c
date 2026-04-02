#include <stdio.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>



u32 compile_program(const char *v_path, const char *f_path) {
    reader *v_reader = reader_create_from_file((char *)v_path);
    reader *f_reader = reader_create_from_file((char *)f_path);

    u32 v_shader = glCreateShader(GL_VERTEX_SHADER);
    u32 f_shader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(v_shader, 1, (const char *const *)&v_reader->buf, null);
    glShaderSource(f_shader, 1, (const char *const *)&f_reader->buf, null);
    glCompileShader(v_shader);
    glCompileShader(f_shader);
    u32 prog = glCreateProgram();
    glAttachShader(prog, v_shader);
    glAttachShader(prog, f_shader);
    glLinkProgram(prog);

    glDeleteShader(v_shader);
    glDeleteShader(f_shader);

    reader_destroy(v_reader);
    reader_destroy(f_reader);

    return prog;
}



int main() {
    glfwInit();

    GLFWwindow *window = glfwCreateWindow(1280, 720, "TEST", NULL, NULL);



    glfwMakeContextCurrent(window);

    glewInit();


    f32 pos[] = {
        0.5, 0.5,
        0.5, -0.5,
        -0.5, -0.5,
        -0.5, 0.5
    };

    u32 indeces[] = {
        1, 2, 3, 3, 1, 0
    };

    u32 VAO, VBO, EBO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(pos), pos, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indeces), indeces, GL_STATIC_DRAW);

    u32 prog = compile_program("./fragment.glsl", "./vertex.glsl");
    glUseProgram(prog);

    printf("Start main loop\n");

    while(!glfwWindowShouldClose(window)) {

        glClear(GL_COLOR_BUFFER_BIT);
        glUniform4f(glGetUniformLocation(prog, "u_Color"), 0.2, 0.3, 0.4, 1.0);

        glBindVertexArray(VAO);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

        glfwSwapBuffers(window);
        glfwPollEvents();

    }

    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
