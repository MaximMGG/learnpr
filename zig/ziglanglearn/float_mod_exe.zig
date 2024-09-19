const std = @import("std");

extern fn foo_strict(x: f64) f64;
extern fn foo_optimized(x: f64) f64;

pub fn main() void {
    const x = 0.001;
    std.debug.print("optimezed = {d}\n", .{foo_optimized(x)});
    std.debug.print("strict = {d}\n", .{foo_strict(x)});
}
