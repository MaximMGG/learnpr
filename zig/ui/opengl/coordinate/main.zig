const std = @import("std");
const c = @import("c");
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));

pub fn main() void {
    _ = c.glfwInit();
    std.debug.print("Hello world\n", .{});
    _ = c.glfwTerminate();
}
