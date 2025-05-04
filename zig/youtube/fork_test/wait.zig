const std = @import("std");
const c = @cImport({
    @cInclude("sys/wait.h");

});

fn child_function() void {
    std.debug.print("[child] [{d}] running\n", .{std.c.getpid()});
    std.Thread.sleep(2000000000);
    std.c._exit(0);
}


pub fn main() !void {
    const child_num = 5;
    for(0..child_num) |_| {
        if (try std.posix.fork() == 0) {
            child_function();
        }
    }

    for(0..child_num) |_| {
        _ = c.wait(null);
    }

    std.debug.print("[parent] all processes finished\n", .{});
}
