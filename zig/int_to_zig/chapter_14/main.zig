const std = @import("std");
const c = @cImport(@cInclude("stdio.h"));


pub fn main() !void {
    var msg = "Super msg";

    _ = c.printf("%s\n", msg[0..].ptr);
}
