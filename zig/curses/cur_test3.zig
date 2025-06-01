const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
    @cInclude("stdlib.h");
});

pub fn main () !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var row: c_int = 0;

    const f = c.fopen(args[1].ptr, "r");
    if (f == null) {
        return error.FopenError;
    }

}
