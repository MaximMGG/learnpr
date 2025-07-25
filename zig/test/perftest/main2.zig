const std = @import("std");
const thread = std.Thread;

const SIZE = 10_000_000;

fn feel_arr(arr: []u32, from: usize, to: usize) void {
    for(from..to, 0..) |index, i| {
        arr[index] = @intCast(i);
    }
}


pub fn main() !void {
    var allocator = std.heap.c_allocator;

    var arr = try allocator.alloc(u32, SIZE * 2);
    defer allocator.free(arr);


    const t1 = try thread.spawn(.{}, feel_arr, .{arr, 0, SIZE});
    const t2 = try thread.spawn(.{}, feel_arr, .{arr, SIZE, SIZE * 2});

    t1.join();
    t2.join();

    for (0..SIZE) |i| {
        arr[i] = arr[i] + arr[i + SIZE];
    }

    std.debug.print("{d}\n", .{arr[SIZE - 1]});

}
