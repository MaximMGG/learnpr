const otherfile = @import("otherfile.zig");
const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const HELLO = "Hello";
    const WORLD = "world!";
    print("{p} {s}\n", .{&HELLO, WORLD});
    
    print("{d}\n", .{otherfile.mult(10, 10)});
}


