const std = @import("std");
const copy = std.mem.copyForwards;

fn catAlloc(allocator: std.mem.Allocator, a: []const u8, b: []const u8) ![]u8 {
    const buf: []u8 = try allocator.alloc(u8, a.len + b.len);
    copy(u8, buf, a);
    copy(u8, buf[a.len..], b);

    return buf;
}

test "fba bytes" {
    const hello = "Hello ";
    const world = "world!";

    var buf: [12]u8 = undefined;

    var fba = std.heap.FixedBufferAllocator.init(&buf);
    const allocator = fba.allocator();

    const res = try catAlloc(allocator, hello, world);
    try std.testing.expectEqualStrings(hello ++ world, res);
}
