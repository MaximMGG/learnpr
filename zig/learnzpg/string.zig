const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const a = [3:false]bool{ false, true, false };
    print("{any}\n", .{std.mem.asBytes(&a).*});

    const str = "Hello";

    print_str(str);

    print("{any}\n", .{@TypeOf(.{ .year = 2024, .month = 8 })});
}

pub fn print_str(s: []const u8) void {
    print("String is {s}\n", .{s});
}
