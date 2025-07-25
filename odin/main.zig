const std = @import("std");


pub fn main() void {
    var acum: u64 = 0;

    for(0..100000) |i| {
        acum += i;
    }

    std.debug.print("{d}\n", .{acum});

}
