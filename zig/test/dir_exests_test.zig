const std = @import("std");

const PATH = "/home/maxim/learnpr/zig/test/genericccc";

pub fn main() !void {
    std.posix.access(PATH, std.posix.F_OK) catch |err| {
        switch(err) {
            std.posix.AccessError.FileNotFound => {
                std.debug.print("Not exists\n", .{});
            },
            else => {}
        }
    };
    std.debug.print("Path exists\n", .{});
  
}
