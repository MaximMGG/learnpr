const std = @import("std");
const c = @cImport({
    @cInclude("sys/wait.h");
});


fn child_function() void {
    std.debug.print("[child] pid - {d}\n", .{std.c.getpid()});
    std.time.sleep(500 * 1000000000);
    std.debug.print("Hello world\n", .{});
    std.c._exit(5);

}


pub fn main() !void {
    const pid: std.posix.pid_t = try std.posix.fork();
    if (pid == 0) {
        child_function();
    }

    var status: i32 = 0;
    _ = std.c.waitpid(pid, &status, 0);

    if (c.WIFEXITED(status)) {
        std.debug.print("Child exit status: {d}\n", .{c.WEXITSTATUS(status)});
    }
    if (c.WIFSIGNALED(status)) {
        std.debug.print("CHild exit signal: {d}\n", .{c.WTERMSIG(status)});
    }
}
