const std = @import("std");
const gl = @import("glad.zig");
const glfw = @import("glfw.zig");

const WIDTH = 1280;
const HEIGHT = 720;

pub fn main() void {
    _ = glfw.glfwInit();

    const window = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Camera window", null, null).?;

    glfw.glfwWindowHint(glfw.GLFW_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    glfw.glfwMakeContextCurrent(window);

    gl.gladLoadGLLoader(@ptrCast(&glfw.glfwGetProcAddress));

    while (glfw.glfwWindowShouldClose(window) == 0) {
        gl.glClearColor(0.2, 0.3, 0.3, 1.0);
        gl.glClea(gl.GL_COLOR_BUFFER_BIT);

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }
}
