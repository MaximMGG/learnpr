const std = @import("std");
const zglm = @import("zglm.zig");

fn printVec2(v: zglm.Vec2(f32)) void {
    std.debug.print("{any}\n", .{v});
}

fn printVec4(v: zglm.Vec4(f32)) void {
    std.debug.print("{any}\n", .{v});
}


pub fn main() void {
    const v = zglm.Vec2(f32).init(.{1.0, 2.0});
    printVec2(v);

    var v4 = zglm.Vec4(f32).init(.{0.2, 0.3, 0.2, 0.1});
    v4.add(zglm.Vec4(f32).init(.{0.1, 0.1, 0.1, 0.1}));
    printVec4(v4);
}
