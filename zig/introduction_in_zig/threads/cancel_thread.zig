const std = @import("std");
const thread = std.Thread;
const stdout = std.io.getStdOut().writer();

var running = std.atomic.Value(bool).init(true);
var counter: u32 = 0;

fn do_work() void {
    std.time.sleep(2 * std.time.ns_per_s);
}

fn work() !void {
    while(running.load(.monotonic)) {
        for(0..10000) |_| {counter += 1;}
        if (counter < 15000) {
            _ = try stdout.write("Time to cancel the thread\n");
            running.store(false, .monotonic);
        } else {
            _ = try stdout.write("Time to do more work\n");
            do_work();
            running.store(false, .monotonic);
        }
    }
}

pub fn main() !void {
    const t = try thread.spawn(.{}, work, .{});
    t.join();
    try stdout.print("counter = {d}\n", .{counter});
}
