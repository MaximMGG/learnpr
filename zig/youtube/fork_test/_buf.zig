const std = @import("std");

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var bw = std.io.bufferedWriter(stdout);
    try bw.writer().print("Hello world!", .{});
    defer {
        bw.flush() catch unreachable;
    }

    _ = try std.posix.fork();
    std.c.exit(0);
}
