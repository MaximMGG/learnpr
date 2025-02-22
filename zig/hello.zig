const std = @import("std");
const print = std.debug.print;

extern fn add(a: i32, b: i32) i32;

pub fn main() !void {
    const a: i32 = 11;
    const b: i32 = 12;
    const c: i32 = add(a, b);
    print("Number after sum is: {}\n", .{c});
    const hello = "Hello";
    print("Hello is {!}\n", .{@TypeOf(hello)});

    const soc: std.c.socket = 0;
    _ = soc;

    var buf: [10]i32 = .{0} ** 10;

    for (&buf) |i| {
        print("{d}\n", .{i});
    }
}
