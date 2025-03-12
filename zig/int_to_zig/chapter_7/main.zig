const std = @import("std");

pub fn main() !void {
    var num: u32 = 0;
    num = return_null(4) orelse 0;
    std.debug.print("{d}\n", .{num});
    num = return_null(5) orelse blk: {
        const a: u32 = 4;
        break :blk a * 11;
    };
    std.debug.print("{d}\n", .{num});

    o: for (0..10) |i| {
        std.debug.print("{d}", .{i});
        if (i == 3) {
            break :o;
        }
        one: for (0..10) |j| {
            if (j == 5) {
                break :o;
            }
            if (j == 9) {
                break :one;
            }
        }
    }
}

fn return_null(num: u32) ?u32 {
    if (num % 2 == 0) {
        return num / 2;
    } else {
        return null;
    }
}
