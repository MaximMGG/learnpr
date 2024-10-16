const std = @import("std");

fn getNum(x: u32) u32 {
    if (x % @as(u32, 2) == 0) {
        return x + @as(u32, 1);
    } else {
        return x;
    }
}

pub fn main() void {
    var x: u32 = 0;

    while (x < 3333333) : (x += 1) {
        x = getNum(x);
        std.debug.print("{d}\n", .{x});
    }
}
