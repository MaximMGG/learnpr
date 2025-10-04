const std = @import("std");
const c = @cImport(@cInclude("stdio.h"));
const glew = @cImport(@cInclude("GL/glew.h"));
const gl = @cImport(@cInclude("GL/gl.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));
const Shader = @import("shader.zig");


const WIDTH = 640;
const HEIGHT = 480;


pub fn main() !void {

    const allocator = std.heap.page_allocator;

    if (glfw.glfwInit() == 0) {
        std.debug.print("glfwInit Fail\n", .{});
        return;
    }

    std.debug.print("glfwInit\n", .{});

    glfw.glfwWindowHint(glfw.GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_CONTEXT_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    const window: *glfw.GLFWwindow = glfw.glfwCreateWindow(WIDTH, HEIGHT, "TEST WINDOW", null, null) orelse {
        std.debug.print("GLFWwindow in null", .{});
        return;
    }; 

    std.debug.print("Ceate window\n", .{});

    glfw.glfwMakeContextCurrent(window);

    if (glew.glewInit() != glew.GLEW_OK) {
        std.debug.print("glewInit fail\n", .{});
        glfw.glfwDestroyWindow(window);
        glfw.glfwTerminate();
        return;
    }

    std.debug.print("glewInit\n", .{});
    glfw.glfwSwapInterval(1);

    var s = try Shader.create("./res/shaders/basic.glsl", allocator);
    defer s.destroy();
    s.bind();

    std.debug.print("GL Version: {s}\n", .{gl.glGetString(gl.GL_VERSION)});

    while(glfw.glfwWindowShouldClose(window) == 0) {
        gl.glClear(gl.GL_COLOR_BUFFER_BIT);


        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }

    glfw.glfwDestroyWindow(window);
    glfw.glfwTerminate();

}
