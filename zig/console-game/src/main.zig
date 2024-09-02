//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const std = @import("std");

pub const name = extern struct { name: [*:0]const u8, name_len: i32 };
pub extern "c" fn print_name(n: *const name) void;

pub extern "c" fn printf(fmt: [*:0]const u8, ...) i32;

pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();
    const stdin = std.io.getStdIn().reader();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});
    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    // var x = 0;

    const c: anyerror!u8 = try stdin.readByte();

    try stdout.print("{!c}\n", .{c});
    try bw.flush();

    for (0..30) |_| {
        for (0..100) |_| {
            try stdout.print("#", .{});
        }
        try stdout.print("\n", .{});
    }
    try stdout.print("\n", .{});

    try bw.flush();

    _ = printf("HELLO WORLD FROM C\n");

    const n = name{ .name = "Antony", .name_len = 6 };

    print_name(&n);
}
