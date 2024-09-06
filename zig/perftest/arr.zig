const std = @import("std");
const print = std.debug.print;
const stdout = @cImport(@cInclude("stdio.h"));

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();
    var arr = std.ArrayList([]const u8).init(alc);
    defer arr.deinit();

    for (0..1000000) |i| {
        if (i % 7 == 0 or i % 10 == 7) {
            try arr.append("SMAC");
        } else {
            var buf: [64]u8 = .{0} ** 64;
            const _buf = try std.fmt.bufPrint(&buf, "{d}", .{@as(i32, @intCast(i))});
            try arr.append(_buf);
        }
    }

    for (arr.items) |c| {
        std.debug.print("{s}\n", .{c});
    }
}
