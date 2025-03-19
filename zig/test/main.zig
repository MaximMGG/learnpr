const std = @import("std");

pub fn main() !void {
    var buf: [1024]u8 = .{0} ** 1024;
    const s_path = try std.fs.selfExeDirPath(buf[0..buf.len]);
    std.debug.print("{s}\n", .{s_path});
}
