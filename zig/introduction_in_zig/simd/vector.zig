const std = @import("std");



pub fn main() void {
    const v1 = @Vector(4, u32){4, 8, 1, 9};
    const v2 = @Vector(4, u32){98, 3, 99, 1};

    const res = v1 * v2;
    std.debug.print("{any}\n", .{res});


    const a = [4]u32{34, 11, 94, 7};
    const v3:  @Vector(4, u32) = a;
    const v4: @Vector(2, u32) = a[1..3].*;
    std.debug.print("{any}\n", .{v3});
    std.debug.print("{any}\n", .{v4});


    std.debug.print("splat\n", .{});

    const v5: @Vector(10, u32) = @splat(3434);

    std.debug.print("{any}\n", .{v5});


}
