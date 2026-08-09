const std = @import("std");
const c = @import("c");
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));
const gl = @cImport(@cInclude("glad/glad.h"));

const WIDTH = 1280;
const HEIGHT = 720;

pub fn main(init: std.process.Init) !void {
    _ = init;
    _ = glfw.glfwInit();
    defer glfw.glfwTerminate();

    const window = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Hello", null, null);
    defer glfw.glfwDestroyWindow(window);

    glfw.glfwWindowHint(glfw.GLFW_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);
    glfw.glfwMakeContextCurrent(window);

    _ = gl.gladLoadGLLoader(@ptrCast(&glfw.glfwGetProcAddress));

    while(glfw.glfwWindowShouldClose(window) == 0) {
        gl.glClearColor(0.2, 0.3, 0.3, 1.0);
        gl.glClear(gl.GL_COLOR_BUFFER_BIT);

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }

    //_ = c.glfwTerminate();
    _ = glfw.glfwTerminate();
}
