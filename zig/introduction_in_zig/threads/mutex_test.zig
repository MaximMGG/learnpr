const std = @import("std");
const thread = std.Thread;

var i_mutex = thread.Mutex{};
var i: u64 = 0;

fn increment() void {
    for(0..1000000) |_| {
        i_mutex.lock();
        i += 1;
        i_mutex.unlock();
    }
}


pub fn main() !void {
    const t1 = try thread.spawn(.{}, increment, .{});
    const t2 = try thread.spawn(.{}, increment, .{});

    t1.join();
    t2.join();

    std.debug.print("i = {d}\n", .{i});
}
