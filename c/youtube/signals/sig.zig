const std = @import("std");


pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    if (args.len != 3) {
        std.debug.print("Usage: {s} DEALY STRING\n", .{args[0]});
        std.c.exit(1);
    }

    std.debug.print("{s}: my pid is {d}\n", .{args[0], std.c.getpid()});

    const delay = try std.fmt.parseInt(u32, args[1], 10);
    var count: u32 = 1;
    while(true) {
        std.time.sleep(delay * std.time.ns_per_s);
        std.debug.print("{d} {d}: {s}\n", .{std.c.getpid(), count, args[2]});
        count += 1;
    }
}
