const std = @import("std");
const expect = std.testing.expect;
const Stack = @import("stack.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var s = try Stack.Stack(u32).init(allocator, 5);
    defer s.deinit();
    try s.push(32);
    try s.push(33);
    try s.push(34);
    try s.push(35);
    try s.push(36);
    try s.push(37);

    std.debug.print("capacity: {d}\n", .{s.capacity});

    for(0..s.len) |i| {
        std.debug.print("len {d}; {d} - {d}\n", .{s.len, i, s.pop()});
    }

    std.debug.print("len: {d}\n", .{s.len});

}

fn comptime_slice(comptime T: type, comptime len: usize) []T {
    var arr: [len]T = undefined;
    return arr[0..len];

}

fn twice(comptime n: i32) i32 {
    return n * 2;
}

test "twice test" {
    try expect(twice(4) == 8);
}

test "slice test" {
    const arr = comptime blk: {
        break :blk comptime_slice(u32, 100);
    };
    arr[0] = 123;
    try expect(arr[0] == 123);
    try expect(arr.len == 100);
}
