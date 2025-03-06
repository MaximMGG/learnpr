const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var n: usize = 0;

    if (builtin.target.os.tag == .windows) {
        n = 10;
    } else {
        n = 12;
    }

    const buffer = try allocator.alloc(u64, n);
    const slice = buffer[0..];
    for (slice, 0..) |d, i| {
        std.debug.print("{d} - index {d}\n", .{ d, i });
    }
    std.debug.print("{any}\n", .{slice});
}
