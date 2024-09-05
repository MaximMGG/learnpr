const std = @import("std");
const calc = @import("test/add.zig");

pub fn main() void {
    std.debug.print("Dependancy test\n", .{});

    if (@as(i32, 15) == calc.add(10, 5)) {
        std.debug.print("add func correct\n", .{});
    }
}

test "main add test" {
    try std.testing.expectEqual(@as(i32, 8), calc.add(3, 5));
}
