const std = @import("std");

pub fn main() !void {
    var buf: [512]u8 = .{0} ** 512;
    _ = try std.posix.getcwd(buf[0..]);
    std.debug.print("{s}\n", .{buf});
    const len = std.mem.len(@as([*:0]u8, @ptrCast(&buf)));
    std.debug.print("{d}\n", .{len});
    std.debug.print("{d}\n", .{buf.len});
    std.mem.copyForwards(u8, buf[len..], "/");
    std.debug.print("{s}\n", .{buf});
}
