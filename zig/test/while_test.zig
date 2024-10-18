const std = @import("std");

pub fn main() void {
    var a: u32 = 0;
    while (getNumber(a)) |value| {
        std.debug.print("{d}\n", .{value});
        if (value == 3333333) return;
        a += 1;
    }
}

fn getNumber(a: u32) ?u32 {
    if (a % @as(u32, 2) == 0) {
        return @intCast(a + 1);
    } else return @intCast(0 + a);
    if (a % @as(u32, 44) == 0) return null;
}
