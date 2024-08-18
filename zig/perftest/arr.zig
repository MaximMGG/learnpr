const std = @import("std");
const print = std.debug.print;
const stdout = @cImport(@cInclude("stdio.h"));

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var list = std.ArrayList(*const [1:0]u8).init(gpa.allocator());
    var i: i32 = 0;

    while (i != 1000000) {
        try list.append("a");
        i += 1;
    }

    _ = stdout.printf("Hello");

    print("list len is: {d}\n", .{i});
    defer list.deinit();
    // defer _ = gpa.deinit();
}
