const std = @import("std");
const print = std.debug.print;



pub fn main() !void {
    var arr: [100000]i32 = undefined;

    for(0..100000) |i| {
        arr[i] = 2 * 5 / 1 + 11 + 33 - 99;
    }

    print("array size is: {}\n", .{arr.len});

}
