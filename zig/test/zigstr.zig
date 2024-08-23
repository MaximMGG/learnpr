const std = @import("std");

pub fn main() void {
    const s = "Hello from zig";

    const s1 = s[0..5];
    print_s(s);
    print_s(s1);

    const space: u32 = find_space(s);

    const s2 = s[0..space];

    print_s(s2);
}

fn print_s(s: []const u8) void {
    std.debug.print("string - {s}\n", .{s});
}

fn find_space(s: []const u8) u32 {
    for (s, 0..) |char, i| {
        if (char == ' ') {
            return @intCast(i);
        }
    }
    return @intCast(0);
}
