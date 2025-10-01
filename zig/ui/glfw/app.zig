const std = @import("std");
const glew = @cImport(@cInclude("GL/glew.h"));
const gl = @cImport(@cInclude("GL/gl.h"));
const glfw = @cImport(@cInclude("GLFW/glfw3.h"));

pub fn main() !void {
    var buf: [1024]u8 = undefined;
    const stdout_writer: std.fs.File.Writer = std.fs.File.stdout().writer(&buf);
    const stdout: *std.Io.Writer = @constCast(&stdout_writer.interface);

    for(1..1001) |i| {
        try stdout.print("{d}. Hello\n", .{i});
    }

    try stdout.flush();

    if (glfw.glfwInit() != 0) {

    }

    glfw.glfwTerminate();
}
