const std = @import("std");
const c = @import("c");
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));

pub fn main(init: std.process.Init) !void {
    _ = init;
    _ = c.glfwInit();

    const window = c.glfwCreateWindow(300, 300, "Hello", null, null);

    while(c.glfwWindowShouldClose(window) != 0) {

        c.glfwSwapBuffers(window);
        c.glfwPollEvents();
    }

    _ = c.glfwTerminate();
}
