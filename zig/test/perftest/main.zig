const std = @import("std");


const SIZE = 10_000_000;

pub fn main() !void {
    var allocator = std.heap.c_allocator;

    var arr = try allocator.alloc(u32, SIZE * 2);
    defer allocator.free(arr);

    for (0..SIZE) |i| {
        arr[i] = @intCast(i);
        arr[i + SIZE] = @intCast(i);
    }

    for (0..SIZE) |i| {
        arr[i] = arr[i] + arr[i + SIZE];
    }

    std.debug.print("{d}\n", .{arr[SIZE - 1]});

}
