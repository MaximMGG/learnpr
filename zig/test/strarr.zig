const std = @import("std");
const mem = std.mem;
const c = @cImport({
    @cInclude("stdio.h");
});
const ci = std.c;


const strErr = error{notlen};

pub fn main() void {
    const str = "Hello";
    const str2 = "Hello3";

//    _ = c;

    std.debug.print("{!}\n", .{@TypeOf(str)});
    std.debug.print("{!}\n", .{@TypeOf(str2)});

    const arr: [2][]const u8 = .{str, str2};

    std.debug.print("string 1: {s}\n", .{arr[0]});
    std.debug.print("string 2: {s}\n", .{arr[1]});
    std.debug.print("{!}\n", .{@TypeOf(arr)});

    const olstr: [*]const u8 = "old string";
    const fmt: [*]const u8 = "old string is: %s\n";

    _ = c.printf(fmt, olstr);

}


