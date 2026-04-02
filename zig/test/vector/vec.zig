const std = @import("std");

const Vec3 = @Vector(3, f32);

pub fn mult(v: *Vec3, m: f32) void {
    v.* *= @as(Vec3, .{m, m, m});
}


pub fn main() void {
    const v1 = Vec3{1.2, 3.4, 3.8};
    const v2 = Vec3{2.4, 8.1, 1.1};
    var v3 = Vec3{1.1, 1.2, 1.3};
    std.debug.print("{any}\n", .{v1});
    std.debug.print("{any}\n", .{v2});
    std.debug.print("{any}\n", .{v1 * @as(@Vector(3, f32), .{1.1, 1.1, 1.1})});
    std.debug.print("{any}\n", .{v1 * v2});

    mult(&v3, @as(f32, 1.1));

    std.debug.print("{any}\n", .{v3});

}
