const std = @import("std");
const print = std.debug.print;

const math = @cImport({
    @cDefine("INCREMENT_BY", "10");
});

extern "c" fn add(a: c_int, b: c_int) c_int;
extern "c" fn increment(a: c_int) c_int;

pub fn main() !void {
    const a = 21;
    const b = 21;
    const c = add(a, b);

    print("zig: a + b == {}\n", .{c});
    print("zig: a++ == {}\n", .{increment(a)});

    _ = std.c.printf("zig: a + b == %d\n", c);
}
