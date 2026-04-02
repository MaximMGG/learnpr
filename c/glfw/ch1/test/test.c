#include <stdio.h>
#include <alloca.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>
#include <cstdext/core/string.h>


#define WIDTH 640
#define HEIGHT 480



typedef struct {
    str vertexShader;
    str fragmentShader;
} ShaderProgramSource;


ShaderProgramSource parseShader(str file_name) {
    reader *r = reader_create_from_file(file_name, 4096);
    str_buf *sb[2] = {str_buf_create(), str_buf_create()};
    str line = reader_read_until_del(r, '\n');
    u32 shader = 0;

    while(line != null) {
        if (strstr(line, "#shader") != null) {
            if (strstr(line, "vertex") != null) {
                shader = 0;
            } else if (strstr(line, "fragment") != null) {
                shader = 1;
            }
        } else {
            str_buf_append_format(sb[shader], "%s\n", line);
        }
        line = reader_read_until_del(r, '\n');
    }

    ShaderProgramSource prog = {.vertexShader = str_buf_to_string(sb[0]), 
    .fragmentShader = str_buf_to_string(sb[1])};
    printf("Vertex shader\n%s\n", prog.vertexShader);
    printf("Fragment shader\n%s\n", prog.fragmentShader);
    str_buf_destroy(sb[0]);
    str_buf_destroy(sb[1]);

    return prog;
}


static u32 compileShader(const str source, u32 type) {
    u32 id = glCreateShader(type);
    glShaderSource(id, 1, &source, null);
    glCompileShader(id);

    i32 result;
    glGetShaderiv(id, GL_COMPILE_STATUS, &result);
    if (result == GL_FALSE) {
        i32 length;
        glGetShaderiv(id, GL_INFO_LOG_LENGTH, &length);
        str message = alloca(length + 1);
        glGetShaderInfoLog(id, length, &length, message);
        log(ERROR, "Failed compile shader %s %s", type == GL_VERTEX_SHADER ? "vertex" :
                "fragment", message);

        glDeleteShader(id);
        return 0;
    }
    return id;
}

u32 CreateShader(str vertexShader, str fragmentSahder) {
    u32 program = glCreateProgram();
    u32 vs = compileShader(vertexShader, GL_VERTEX_SHADER);
    u32 fs = compileShader(fragmentSahder, GL_FRAGMENT_SHADER);

    glAttachShader(program, vs);
    glAttachShader(program, fs);
    glLinkProgram(program);
    glValidateProgram(program);

    glDeleteShader(vs);
    glDeleteShader(fs);

    return program;
}

int main() {
    log(INFO, "Start APP");

    if (!glfwInit()) {
        log(FATAL, "glfwInit error");
        return 1;
    }

    log(INFO, "glfwInit");

    GLFWwindow *window = glfwCreateWindow(WIDTH, HEIGHT, "TEST WINDOW 2", null, null);
    if (window == null) {
        log(FATAL, "glfwCreateWindow error");
        glfwTerminate();
        return 1;
    }

    glfwMakeContextCurrent(window);

    if (glewInit() != GLEW_OK) {
        log(FATAL, "glewInit error");
        glfwTerminate();
        return 1;
    }

    log(INFO, "glewInit");


    f32 position[] = {
        -0.5f, -0.5f,
         0.5f, -0.5f,
         0.5f,  0.5f,
        -0.5f,  0.5f
    };

    u32 indeces[] = {
        0, 1, 2, 2, 3, 0
    };

    u32 vao;

    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);

    u32 buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(position), position, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(u32) * 2, (ptr)0);

    u32 ibo;
    glGenBuffers(1, &ibo);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ibo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indeces), indeces, GL_STATIC_DRAW);


    ShaderProgramSource source = parseShader("./res/shaders/Basic.glsl");

    u32 shader = CreateShader(source.vertexShader, source.fragmentShader);
    glUseProgram(shader);

    i32 location = glGetUniformLocation(shader, "u_Color");
    glUniform4f(location, 0.2f, 0.3f, 0.8f, 1.0f);

    glBindVertexArray(0);
    glUseProgram(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

    f32 r = 0;
    f32 inc = 0.05;

    while(!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT); 

        glUseProgram(shader);

        glUniform4f(location, 0.3f, r, 0.8f, 1.0f);
        glBindVertexArray(vao);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ibo);
        
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null);

        if (r > 1.0f) {
            inc = -0.05f;
        } else if (r < 0.0f) {
            inc = 0.05f;
        }
        r += inc;

        glfwSwapBuffers(window);
        glfwPollEvents();
        usleep(50000);
    }

    glDeleteProgram(shader);
    glfwDestroyWindow(window);
    glfwTerminate();

    log(INFO, "End APP");
    return 0;
}
