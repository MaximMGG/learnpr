const std = @import("std");


pub fn main() !void {
    std.debug.print("I'm printed once\n", .{});

    const pid: std.c.pid_t = try std.posix.fork();

    std.debug.print("I'm printed twice\n", .{});

    while(true) {
        std.debug.print("[{d}] pid return after fork: {d} parent pid: {d}\n", .{
            std.c.getpid(), pid, std.c.getppid()
        });

        std.time.sleep(100000000);
    }

}
