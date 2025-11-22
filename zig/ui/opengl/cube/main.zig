const std = @import("std");

const gl = @cImport(@cInclude("GL/glew.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));


const WIDTH = 1280;
const HEIGHT = 720;


pub fn main() void {
    _ = glfw.glfwInit();

    const window: *glfw.GLFWwindow = glfw.glfwCreateWindow(WIDTH, HEIGHT, "CUBE APP", null, null) orelse return;
    glfw.glfwMakeContextCurrent(window);

    const glew_res = gl.glewInit();
    if (glew_res != 0 and glew_res != 4) {
        std.debug.print("Glew error\n", .{});
        return;
    }

    while(glfw.glfwWindowShouldClose(window) != 0) {
        gl.glClear(gl.GL_COLOR_BUFFER_BIT);

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }

    glfw.glfwDestroyWindow(window);
    glfw.glfwTerminate();
}
