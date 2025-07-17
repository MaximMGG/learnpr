const std = @import("std");
const stdout = std.io.getStdOut().writer();
const thread = std.Thread;

fn do_some_work() !void {
    _ = try stdout.write("Startin do the work\n");
    std.time.sleep(100 * std.time.ns_per_ms);
    _ = try stdout.write("Finishing to do the work\n");
}


pub fn main() !void {
    const t = try thread.spawn(.{}, do_some_work, .{});
    t.join();
}

