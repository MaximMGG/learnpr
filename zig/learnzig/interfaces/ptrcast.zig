const std = @import("std");

pub fn main() !void {
    var n = num2{ .a = 123, .b = 133 };
    const byte: [*]u8 = @ptrCast(&n);
    const i: *i32 = @ptrCast(@alignCast(byte + 4));

    std.debug.print("{d}\n", .{i.*});
}

const num = struct { a: i32, b: f32 };

const num2 = struct { a: i32, b: i32 };
