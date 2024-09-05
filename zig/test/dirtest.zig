const std = @import("std");

const BUF_LEN = 512;

pub fn main() !void {
    var absolute_path: [BUF_LEN]u8 = .{0} ** BUF_LEN;
    _ = try std.posix.getcwd(&absolute_path);
    std.debug.print("cwd -> {s}\n", .{absolute_path});
    const dir = try std.fs.openDirAbsolute(&absolute_path, .{ .iterate = true });
    std.debug.print("{any}\n", .{dir});
}
