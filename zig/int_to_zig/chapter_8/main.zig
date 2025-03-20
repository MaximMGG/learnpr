const std = @import("std");
const expect = std.testing.expect;
const expectError = std.testing.expectError;
const expectEql = std.testing.expectEqual;
const expectEqualSlice = std.testing.expectEqualSlices;
const expectEqualString = std.testing.expectEqualStrings;

test "testing simple sum" {
    const a: u8 = 2;
    const b: u8 = 6;
    try expect(a + b == 8);
}

fn some_memory_leak(allocator: std.mem.Allocator, comptime T: type) ![]T {
    const buffer = try allocator.alloc(T, 500);
    return buffer;
}

test "allocator test" {
    const buffer = try some_memory_leak(std.testing.allocator, i32);

    std.testing.allocator.free(buffer);
}

fn alloc_error(allocator: std.mem.Allocator) !void {
    var ibuffer = try allocator.alloc(u8, 100);
    defer allocator.free(ibuffer);
    ibuffer[0] = 2;
}

test "testing error" {
    var buffer: [10]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    try expectError(error.OutOfMemory, alloc_error(allocator));
}

test "testing equalse" {
    const a: u32 = 13;
    const b: u32 = 13;
    try expectEql(a, b);
}

test "testing equalseSlice" {
    const a = [_]u8{ 1, 2, 5 };
    const b = [_]u8{ 1, 2, 5 };
    // std.debug.print("{any}\n", .{@TypeOf(&a)});
    try expectEqualSlice(u8, &a, &b);
}
test "testing equalseString" {
    const a: []const u8 = "Hello world";
    const b = "Hello world";
    try expectEqualString(a, b);
}
