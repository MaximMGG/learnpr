const std = @import("std");

const foo = struct { x: i32, y: u16, z: u8, q: u4, w: u4 };
const fo2 = packed struct { x: i32, y: u16, z: u8, q: u4, w: u4 };

pub fn main() !void {
    std.debug.print("Sizeof not packed struct {d}\n", .{@sizeOf(foo)});
    std.debug.print("Sizeof packed struct {d}\n", .{@sizeOf(fo2)});
}
