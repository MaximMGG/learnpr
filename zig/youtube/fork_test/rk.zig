const std = @import("std");

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    try stdout.print("I'm printed once\n", .{});

    const pid: std.c.pid_t = try std.posix.fork();

    try stdout.print("I'm printed twice\n", .{});

    while(true) {
        if (pid == 0) {
            try stdout.print("Child - [{d}] pid return after fork: {d} parent pid: {d}\n", .{
                std.c.getpid(), pid, std.c.getppid()
            });

        } else {
            try stdout.print("Parent - [{d}] pid return after fork: {d} parent pid: {d}\n", .{
                std.c.getpid(), pid, std.c.getppid()
            });
        }

        std.time.sleep(100000000);
    }

}
