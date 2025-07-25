const std = @import("std");

const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

pub fn main() !void {
    const f = try std.fs.cwd().openFile("../hash_map.zig", .{.mode = .read_only});
    defer f.close();

    var fbuffered = std.io.bufferedReader(f.reader());
    const reader = fbuffered.reader();

    var buf: [1000]u8 = .{0} ** 1000;

    //_ = try reader.readUntilDelimiterOrEof(&buf, '\n');
    _ = try reader.readAll(&buf);

    try stdout.print("File content\n {s}\n", .{buf});

}

//New commend under cod
