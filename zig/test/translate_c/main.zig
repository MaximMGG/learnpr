const glfw = @import("glfw.zig");
const glad = @import("glad.zig");
const std = @import("std");

const WIDTH = 1280;
const HEIGHT = 720;

pub fn main() void {
    _ = glfw.glfwInit();

    const window = glfw.glfwCreateWindow(WIDTH, HEIGHT, "Ttest", null, null).?;

    glfw.glfwWindowHint(glfw.GLFW_VERSION_MAJOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_VERSION_MINOR, 3);
    glfw.glfwWindowHint(glfw.GLFW_OPENGL_PROFILE, glfw.GLFW_OPENGL_CORE_PROFILE);

    glfw.glfwMakeContextCurrent(window);

    _ = glad.gladLoadGLLoader(@ptrCast(&glfw.glfwGetProcAddress));

    while (glfw.glfwWindowShouldClose(window) == 0) {
        glad.glClearColor(0.2, 0.3, 0.3, 1.0);
        glad.glClear(glad.GL_COLOR_BUFFER_BIT);

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }

    glfw.glfwDestroyWindow(window);
    glfw.glfwTerminate();
}
