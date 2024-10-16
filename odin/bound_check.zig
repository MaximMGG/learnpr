const std = @import("std");

pub fn main() void {
    var arr: [100000]i32 = .{0} ** 100000;
    var num: i32 = 0;

    for (0..100000) |i| {
        arr[i] = num;
        num += 1;
    }
    for (arr) |c| {
        std.debug.print("{d}\n", .{c});
    }
}
