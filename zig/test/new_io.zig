const std = @import("std");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, world!\n");
    std.debug.print("Another Hello, {s}\n", .{"World"});
}
