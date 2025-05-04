const std = @import("std");


pub fn main() !void {
    var x: i32 = 100;

    const pid: std.posix.pid_t = try std.posix.fork();
    if (pid == 0) {
        std.time.sleep(500000000);
        std.debug.print("[Child] x = {d} ppid: {d}\n", .{x, std.c.getppid()});
        std.c._exit(0);
    }

    std.debug.print("[Parent] x = {d}\n", .{x});
    x = 1000;
}
