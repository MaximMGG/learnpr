const std = @import("std");

pub fn main() !void {
    const b = 0b10010011;
    std.debug.print("{b}\n", .{b & 0b00110000});
}
