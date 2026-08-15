const std = @import("std");
const glm = @cImport(@cInclude("cglm/cglm.h"));



pub fn main() void {
    var m: glm.mat4 = .{.{1.0, 0.0, 0.0, 0.0}, 
                        .{0.0, 1.0, 0.0, 0.0}, 
                        .{0.0, 0.0, 1.0, 0.0}, 
                        .{0.0, 0.0, 0.0, 1.0}};

    glm.glm_perspective(45.0, 1280.0 / 720.0, 0.1, 100.0, @alignCast(@ptrCast(m[0..])));

    std.debug.print("{any}\n", .{m});
}
