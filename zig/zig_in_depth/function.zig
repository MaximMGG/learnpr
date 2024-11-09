const std = @import("std");
const print = std.debug.print;

fn add(a: u8, b: u8) u8 {
    return a +| b;
}

fn printU8(x: u8) void {
    print("{}\n", .{x});
}

fn oops() noreturn {
    @panic("oops");
}

fn never() void {
    @compileError("Never happens...");
}

pub fn sub(a: u8, b: u8) u8 {
    return a -| b;
}

extern "c" fn atan2(a: f64, b: f64) f64;

export fn mul(a: u8, b: u8) u8 {
    return a *| b;
}

inline fn answer() u8 {
    return 42;
}

fn addOne(a: *u8) void {
    a.* += 1;
}

pub fn main() !void {
    var a: u8 = 7;
    addOne(&a);
    printU8(a);
}
