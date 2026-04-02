const std = @import("std");
const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("unistd.h");
});


pub fn main() void {
    std.debug.print("Process Id (pid): {d}\n", .{std.c.getpid()});
    std.debug.print("Parent Pid: {d}\n", .{std.c.getppid()});
    std.time.sleep(10000 * 1000000);
}
