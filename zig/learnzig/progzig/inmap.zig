const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();

    var lookup = std.StringHashMap(User).init(alc);
    defer lookup.deinit();

    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var i: i32 = 0;
    while (true) : (i += 1) {
        var buf: [64]u8 = undefined;
        try stdout.print("Please enter a name: ", .{});
        if (try stdin.readUntilDelimiterOrEof(&buf, '\n')) |line| {
            var name = line;
            if (builtin.os.tag == .windows) {
                name = std.mem.trimRight(u8, name, "\r");
            }
            if (name.len == 0) {
                break;
            }
            try lookup.put(name, .{ .power = i });
            std.debug.print("insert -> {s}\n", .{name});
        }
    }
    const has_leto = lookup.contains("Leto");
    std.debug.print("{any}\n", .{has_leto});
}

const User = struct { power: i32 };
