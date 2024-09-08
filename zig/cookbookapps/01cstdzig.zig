const std = @import("std");
const c = std.c;
const stdio = @cImport(@cInclude("stdio.h"));

pub fn main() !void {
    const f: *stdio.FILE = stdio.fopen("test2.txt", "r").?;

    var buf: [128:0]u8 = .{0} ** 128;
    var i: usize = 0;

    while (stdio.feof(f) != -1) {
        _ = stdio.fgets(buf[0..128].ptr, 128, f);
        i += 1;
        if (buf.len == 0) break;
        std.debug.print("{d} - {s}", .{ i, buf });
        @memset(buf[0..128], 0);
    }
    _ = stdio.fclose(f);
}
