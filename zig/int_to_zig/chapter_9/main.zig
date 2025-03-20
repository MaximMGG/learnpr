const std = @import("std");
const stdout = std.io.getStdOut().writer();

const expect = std.testing.expect;


pub fn main() !void {
    var stdout_b = std.io.bufferedWriter(stdout);
    const bufout = stdout_b.writer();
    try bufout.print("Hello world!\n", .{});
    try stdout_b.flush();
}


test "test23" {
    const a: u32 = 1;
    const b: u64 = 123;
    try expect(a + b == 124);
}
