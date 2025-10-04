const std = @import("std");
const glew = @cImport(@cInclude("GL/glew.h"));
const gl = @cImport(@cInclude("GL/gl.h"));
const glfw = @cImport(@cInclude({"GLFW/glfw3.h";}));


const WIDTH = 640;
const HEIGHT = 480;


pub fn main() !void {

    if (glfw.glfwInit() == 0) {
        std.debug.print("glfwInit Fail\n", .{});
        return;
    }

    std.debug.print("glfwInit\n", .{});

    glfw.glfwWindowHint(glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    const window: ?*glfw.GLFWwindow = glfw.glfwCreateWindow(WIDTH, HEIGHT, "TEST WINDOW", null, null);



    glfw.glfwTerminate();
}
