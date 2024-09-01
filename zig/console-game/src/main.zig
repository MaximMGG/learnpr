//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const std = @import("std");

pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});
    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    // var x = 0;

    for (0..30) |_| {
        for (0..100) |_| {
            try stdout.print("#", .{});
        }
        try stdout.print("\n", .{});
    }
    try stdout.print("\n", .{});

    try bw.flush();

    const reader = std.io.getStdIn().reader();
    var buf: [512]u8 = .{0} ** 512;

    const r_buf = try reader.readUntilDelimiter(&buf, '\n');

    try stdout.print("Input is: {s}\n", .{buf});
    try stdout.print("r_buf is {s}\n", .{r_buf});

    try bw.flush();

    try stdout.print("Own style\n", .{});

    var buf2: [512]u8 = .{0} ** 512;
    var i: usize = 0;
    var c: u8 = 1;

    while (i < 512) : (i += 1) {
        c = try reader.readByte();
        if (c == '\n') {
            break;
        }
        buf2[i] = c;
    }

    try stdout.print("Buf2 is: {s}\n", .{buf2});

    try bw.flush();
}
