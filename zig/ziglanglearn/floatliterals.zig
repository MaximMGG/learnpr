const std = @import("std");

const inf = std.math.inf(f32);
const negative_inf = -std.math.inf(f64);
const nan = std.math.nan(f128);

pub fn main() void {
    std.debug.print("{any}\n", .{inf});
    std.debug.print("{any}\n", .{negative_inf});
    std.debug.print("{any}\n", .{nan});
}
