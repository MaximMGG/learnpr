const std = @import("std");
const Base64 = @import("base64.zig").Base64;

const stdout = std.io.getStdOut().writer();



pub fn main() !void {
    const base64 = Base64.init();
    try stdout.print("Character at index 28: {c}\n", .{base64._char_at(28)});
}
