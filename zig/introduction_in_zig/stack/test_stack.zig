const std = @import("std");
const stack = @import("stack_impl.zig");


pub fn main() !void {
    const allocator = std.heap.c_allocator;

    var set = try stack.Stack(u32).init(allocator);
    defer set.deinit();

    try set.push(876);
    try set.push(777);
    try set.push(666);
    try set.push(555);
    try set.push(444);


    for(set.data, 0..) |d, i| {
        std.debug.print("{d} - {d}\n", .{d, i});
    }

    for(0..5) |_| {
        std.debug.print("{d}\n", .{set.pop()});
    }

}
