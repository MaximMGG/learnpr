#include <stdio.h>
#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cstdext/core.h>
#include <cstdext/io/logger.h>
#include <cstdext/io/reader.h>


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

    f32 pos2 = {

    };



    glfwDestroyWindow(window);
    glfwTerminate();
    log(INFO, "End prog");
    return 0;

fatal_error:
    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
