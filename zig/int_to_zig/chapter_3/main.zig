const std = @import("std");
const c = std.c;
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var buffer: []u8 = try allocator.alloc(u8, 500);
    defer allocator.free(buffer);
    try stdout.print("Address of buffer {p}\n", .{&buffer});
    try stdout.print("Address of buffer.ptr {p}\n", .{&buffer.ptr});
    try stdout.print("Address of buffer.len {p}\n", .{&buffer.len});

    var buf: []u8 = undefined;
    buf.ptr = @alignCast(@ptrCast(c.malloc(500).?));
    defer c.free(@ptrCast(buf));
    buf.len = 500;
    buf.ptr[0] = 'A';
    @memset(buf[0..buf.len], 3);
    try stdout.print("{any}\n", .{@TypeOf(buf)});
    try stdout.print("pointer to buf {any}\n", .{&buf});
    try stdout.print("poiner to buf.ptr {any}\n", .{&buf.ptr});
    try stdout.print("poiner to buf.len {any}\n", .{&buf.len});
    try stdout.print("{any}\n", .{buf});

    for (0..buf.len) |i| {
        if (i % 7 == 0) {
            buf[i] = 77;
        }
    }
    stack_example();
}

fn add(x: u8, y: u8) u8 {
    const result = x + y;
    return result;
}

fn stack_example() void {
    const r = add(5, 27);
    _ = r;
}
