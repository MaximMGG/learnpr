const std = @import("std");
const testing = std.testing;

const expectError = testing.expectError;

fn error_alloc(allocator: std.mem.Allocator) !void {
    var ibuf = try allocator.alloc(u8, 100);
    defer allocator.free(ibuf);
    ibuf[0] = 2;
}

test "aloc test" {
    var buf: [10]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    const allocator = fba.allocator();
    try expectError(error.OutOfMemory, error_alloc(allocator));
}
