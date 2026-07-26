const std = @import("std");
const gl = @import("glad.zig");
const glfw = @import("glfw.zig");
const shader = @import("shader.zig");

const WIDTH = 1280;
const HEIGHT = 720;

pub fn main(init: std.process.Init) !void {
    _ = init;
    _ = glfw.glfwInit();
    const allocator = std.heap.page_allocator;
    _ = allocator;

    const window = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Camera window", null, null).?;

    glfw.glfwWindowHint(glfw.GLFW_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    glfw.glfwMakeContextCurrent(window);

    _ = gl.gladLoadGLLoader(@ptrCast(&glfw.glfwGetProcAddress));

    // const s = shader.Shader.init(allocator);
    // const program = try s.createProgram("vertex.glsl", "fragment.glsl", init.io);
    // _ = program;

    while (glfw.glfwWindowShouldClose(window) == 0) {
        gl.glClearColor(0.2, 0.3, 0.3, 1.0);
        gl.glClear(gl.GL_COLOR_BUFFER_BIT);




        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }
}
