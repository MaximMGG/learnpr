const std = @import("std");
const Thread = std.Thread;
var m = Thread.Mutex{};


var num: u32 = 0;



fn do_work(count: *usize) void {
    for(0..count.*) |_| {
        add_one();
    }
}

fn add_one() void {
    m.lock();
    num += 1;
    m.unlock();
}

pub fn main() !void {
    var count: usize = 100_000_000;
    const t1 = try Thread.spawn(.{}, do_work, .{&count});


    for(0..count) |_| {
        m.lock();
        num += 1;
        m.unlock();
    }
    t1.join();

    std.debug.print("Num: {d}\n", .{num});

}
