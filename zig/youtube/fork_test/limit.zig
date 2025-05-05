const std = @import("std");


pub fn main() !void {
    var counter: i32 = 1;
    var pid: std.c.pid_t = 0;

    while(pid == 0) {
        std.time.sleep(1 * 1000000000);
        pid = try std.posix.fork();
        if (pid != -1) {
            counter += 1;
        } else {
            std.debug.print("error", .{});
        }
    }

    if (pid > 0) {
        std.c.waitpid(pid, null, 0);
    } else if (pid == -1) {

    }
}
