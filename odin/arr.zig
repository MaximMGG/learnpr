const std = @import("std");


fn do_job(allocator: std.mem.Allocator, size: usize) ![]i32 {
    var buf = try allocator.alloc(i32, size);
    for (0..buf.len) |i| {
        buf[i] = @as(i32, @intCast(i + 1));
    }

    return buf;
}

pub fn main() !void {
    var allocator = std.heap.c_allocator;

    const buf = try do_job(allocator, 10000000);
    defer allocator.free(buf);


    std.debug.print("{d}\n", .{buf[9999999]});

}
