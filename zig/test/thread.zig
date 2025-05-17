const std = @import("std");

var i: std.atomic.Value(u32) = undefined;

fn foo(id: u32) void {
    var a: u32 = 0;
    for(0..100000) |_| {
        _ = i.fetchAdd(1, .monotonic);
        a += 1;
    }
    std.debug.print("id: {d}, thread, a = {d}\n", .{id, a});
}


pub fn main() !void {
    var threads: [4]std.Thread = undefined;
    i.store(0, .monotonic);
    for(0..4) |j| {
        threads[j] = try std.Thread.spawn(.{}, foo, .{@as(u32, @intCast(j))});
    }

    for(0..4) |j| {
        threads[j].join();
    }

    std.debug.print("Final value {d}\n", .{i.raw});

}
