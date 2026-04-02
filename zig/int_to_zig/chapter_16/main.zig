const std = @import("std");
const Thread = std.Thread;
const stdout = std.io.getStdOut().writer();

var do_work_m: Thread.Mutex = undefined;
var sum: usize = 0;

fn do_work() !void {
    do_work_m.lock();
    _ = try stdout.write("Starting the work.\n");
    std.time.sleep(100 * std.time.ns_per_ms);
    for(0..100) |_| {
        sum += 1;

    }
    _ = try stdout.write("Finishing the work.\n");
    do_work_m.unlock();
}

fn do_work2(id: *const u8) !void {
    try stdout.print("ID of the thread: {d}\n", .{id.*});
}


pub fn main() !void {
    const t1 = try Thread.spawn(.{}, do_work, .{});

    for(0..100) |_| {
        do_work_m.lock();
        sum += 1;
        do_work_m.unlock();
    }

    t1.join();
    try stdout.print("CPU count - {d}\n", .{try Thread.getCpuCount()});

    try stdout.print("Sum: {d}\n", .{sum});

    const id1: u8 = 1;
    const id2: u8 = 2;
    const th1 = try Thread.spawn(.{}, do_work2, .{&id1});
    const th2 = try Thread.spawn(.{}, do_work2, .{&id2});


    try stdout.print("Join Thread 1\n", .{});
    th1.join();
    std.time.sleep(2 * std.time.ns_per_s);
    try stdout.print("Join Thread 2\n", .{});
    th2.join();

    const id3: u8 = 3;
    const th3 = try Thread.spawn(.{}, do_work2, .{&id3});
    th3.detach();

    try stdout.print("Finished main\n", .{});
}
