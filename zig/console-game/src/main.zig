const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    const bw = std.io.bufferedWriter(stdout);

    for(0..30) |_| {
        try stdout.print("\n", .{});
        for(0..100) |_| {
            try stdout.print("#", .{});
        }
    }

    
}
