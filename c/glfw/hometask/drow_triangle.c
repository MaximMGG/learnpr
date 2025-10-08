#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <stdio.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>
#include <unistd.h>

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

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);


    glfwMakeContextCurrent(window);
    log(INFO, "Set current context");

    if (glewInit() != 0) {
        log(FATAL, "Can't initialize OpenGL");
        goto fatal_error;
    }

    //glViewport(0, 0, WIDTH, HEIGHT);
    log(INFO, "set viewport");


    f32 pos[] = {
        0.5f,  0.5f,  // top right
        0.5f, -0.5f,  // bottom right
       -0.5f,  0.5f,  // top left 
       -0.5f, -0.5f,  // bottom left
    };

    u32 index[] = {0, 1, 2, 2, 3, 1};

    u32 VBO; // vertex buffer objects
    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(pos), pos, GL_STATIC_DRAW);
    log(INFO, "Gen VBO");

    u32 VAO; // vertex array object
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);
    log(INFO, "Bind vertex arrats");


    u32 EBO;// elemet buffer array object

    glGenBuffers(1, &EBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(index), index, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    log(INFO, "gl attrib pointer done");


    i8 *vertexShaderSource = shader_data("./vertex.glsl");
    u32 vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, (const char *const *)&vertexShaderSource, null);
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
    glShaderSource(fragmentShader, 1, (const char *const *)&fragmentShaderSource, null);
    glCompileShader(fragmentShader);
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
    f32 r = 0.8f;


    glUseProgram(program);

    glUniform4f(glGetUniformLocation(program, "u_Color"), r, 0.2f, 0.4f, 1.0f);
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);


    log(INFO, "Use pogram");
    dealloc(vertexShaderSource);
    dealloc(fragmentShaderSource);


    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);



    log(INFO, "Start cycle");
    f32 inc = 0.05f;

    while(!glfwWindowShouldClose(window)) {
        //set standard OpenGL backgroud color
        glClearColor(0.2, 0.3, 0.4, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);

        glUseProgram(program);

        glUniform4f(glGetUniformLocation(program, "u_Color"), r, 0.2f, 0.4f, 1.0f);
        if (r > 1.0f) {
            inc = -0.05f;
        } else if (r < 0.0f){
            inc = 0.05f;
        }

        r += inc;


        glBindVertexArray(VAO);
        //glDrawArrays(GL_TRIANGLES, 0, 3);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);


        glfwSwapBuffers(window);
        glfwPollEvents();

        usleep(40000);
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

