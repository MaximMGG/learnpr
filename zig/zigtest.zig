const std = @import("std");

test "expect addOne adds one to 41" {
    try std.testing.expect(addOne(41) == 42);
}

test addOne {
    try std.testing.expect(addOne(41) == 42);
}

fn addOne(a: i32) i32 {
    return a + 1;
}

test "detect leak" {
    var list = std.ArrayList(u21).init(std.testing.allocator);

    try list.append('\x12');

    try std.testing.expect(list.items.len == 1);
}

