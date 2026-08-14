const std = @import("std");
const zglm = @import("zglm.zig");

fn printVec2(v: zglm.Vec2(f32)) void {
    std.debug.print("{any}\n", .{v});
}


pub fn main() void {
    const v = zglm.Vec2(f32).init(.{1.0, 2.0});
    printVec2(v);
}
