const std = @import("std");
const thread = std.Thread;

var i = std.atomic.Value(u64).init(0);

fn increment() void {
    for(0..1000000) |_| {
        _ = i.fetchAdd(1, .monotonic);
    }
}

pub fn main() !void {
    const t1 = try thread.spawn(.{}, increment, .{});
    const t2 = try thread.spawn(.{}, increment, .{});

    t1.join();
    t2.join();

    std.debug.print("i = {d}\n", .{i.load(.monotonic)});

}
