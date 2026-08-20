const std = @import("std");
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));

pub fn main() void {
    _ = glfw.glfwInit();
}
