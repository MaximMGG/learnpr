const print = @import("std").debug.print;

pub fn main() void {
    const str = "Hello";

    print("{s}\n", .{str});
}
