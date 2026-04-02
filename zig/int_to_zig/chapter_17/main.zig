const std = @import("std");



pub fn main() !void {
    const v1 = @Vector(4, u32){4, 12, 37, 9};
    const v2 = @Vector(4, u32){10, 22, 5, 12};
    const v3 = v1 * v2;
    std.debug.print("{any}\n", .{v3});
    std.debug.print("Type of vector4 - {any}\n", .{@TypeOf(v3)});


    const a1 = [_]u32 {8, 7, 6, 5};
    const a2 = [_]u32 {3, 4, 5, 6};
    const v4 = @as(@Vector(4, u32), a1) * @as(@Vector(4, u32), a2);

    std.debug.print("V4 - {any}\n", .{v4});

}
