const std = @import("std");
const Thread = std.Thread;

var num  = std.atomic.Value(u32).init(0);


fn do_work(count: *usize) void {
    for(0..count.*) |_| {
        add_one();
    }
}

fn add_one() void{
    _ = num.fetchAdd(1, .monotonic);
}

pub fn main() !void {
    var count: usize = 100_000_000;
    const th1 = try Thread.spawn(.{}, do_work, .{&count});


    for(0..count) |_|{
        _ = num.fetchAdd(1, .monotonic);
    }
    th1.join();

    std.debug.print("Num: {d}\n", .{num.load(.monotonic)});
}
