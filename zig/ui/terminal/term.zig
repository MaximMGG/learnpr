const std = @import("std");
const pty = @cImport(@cInclude("pty.h"));

var masterfd: *c_int = undefined;

pub fn main() void {

    if (pty.forkpty(@ptrCast(&masterfd), null, null, null) == 0) {
        _ = std.os.linux.execve("/usr/bin/bash", [*:null]const [*:0]const u8{"bash", null}, null);
    }

    std.debug.print("Hello\n", .{});
}
