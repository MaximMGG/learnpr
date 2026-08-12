const std = @import("std");
const gl = @cImport(@cInclude("glad/glad.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));
const shader = @import("shader.zig");

const WIDTH = 1280;
const HEIGHT = 720;

pub fn main(init: std.process.Init) !void {
    _ = glfw.glfwInit();
    defer glfw.glfwTerminate();
    const allocator = std.heap.page_allocator;

    const window = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Camera window", null, null).?;
    defer glfw.glfwDestroyWindow(window);

    glfw.glfwWindowHint(glfw.GLFW_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    glfw.glfwMakeContextCurrent(window);

    _ = gl.gladLoadGLLoader(@ptrCast(&glfw.glfwGetProcAddress));
    //_ = gl.gladLoadGLLoader(glfw.glfwGetProcAddress);

    var s = try shader.Shader(allocator).createProgram("vertex.glsl", "fragment.glsl", init.io);
    defer s.destroy();
    s.use();

    const vertices = [_]f32{
        -0.5, 0.5,
         0.5, 0.5,
         0.5, -0.5,

        -0.5, -0.5,
        0.5, 0.5,
        0.5, -0.5,
    };

    var VAO: u32 = undefined;
    var VBO: u32 = undefined;
    gl.glad_glGenVertexArrays.?(1, @ptrCast(&VAO));
    defer gl.glad_glDeleteVertexArrays.?(1, @ptrCast(&VAO));
    gl.glad_glGenBuffers.?(1, @ptrCast(&VBO));
    defer gl.glad_glDeleteBuffers.?(1, @ptrCast(&VBO));
    gl.glad_glBindVertexArray.?(VAO);

    gl.glad_glBindBuffer.?(gl.GL_ARRAY_BUFFER, VBO);
    gl.glad_glBufferData.?(gl.GL_ARRAY_BUFFER, @sizeOf(f32) * vertices.len, &vertices[0], gl.GL_STATIC_DRAW);

    gl.glad_glVertexAttribPointer.?(0, 2, gl.GL_FLOAT, gl.GL_FALSE, 2 * @sizeOf(f32), @ptrCast(&0));
    gl.glad_glEnableVertexAttribArray.?(0);
    
    s.use();
    while (glfw.glfwWindowShouldClose(window) == 0) {
        gl.glad_glClearColor.?(0.2, 0.3, 0.3, 1.0);
        gl.glad_glClear.?(gl.GL_COLOR_BUFFER_BIT);

        gl.glad_glBindVertexArray.?(VAO);
        gl.glad_glDrawArrays.?(gl.GL_TRIANGLES, 0, 6);

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }
}
