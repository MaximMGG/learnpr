const std = @import("std");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

const S = packed struct {
    a: u32,
    b: u32,
};

test "overaligned pointer to packed struct" {
    var foo: S align(4) = .{ .a = 1, .b = 2 };
    const ptr: *align(4) S = &foo;

    const ptr_to_b: *u32 = &ptr.b;
    try expect(ptr_to_b.* == 2);
}

test "aligned struct fields" {
    const B = struct { a: u32 align(2), b: u32 align(64) };

    var foo = B{ .a = 1, .b = 2 };
    try expectEqual(64, @alignOf(B));
    try expectEqual(*align(2) u32, @TypeOf(&foo.a));
    try expectEqual(*align(64) u32, @TypeOf(&foo.b));
}
