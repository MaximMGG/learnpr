const std = @import("std");

pub fn main() !void {
    const str = "Hello";
    const len: usize = strlen(str);
    std.debug.print("len is {d}\n", .{len});
}

fn strlen(str: [*]const u8) usize {
    var i: usize = 0;
    while (i < 512) : (i += 1) {
        if (str[i] == 0) {
            return i;
        }
    }
    return i;
}
