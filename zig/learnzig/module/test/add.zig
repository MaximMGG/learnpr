const std = @import("std");

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "test add" {
    try std.testing.expectEqual(@as(i32, 10), add(8, 2));
}
