const std = @import("std");
const thread = std.Thread;

const stdout = std.io.getStdOut().writer();


var counter: u32 = 0;
fn reader(rw: *thread.RwLock) !void {
    while(true) {
        rw.lockShared();
        const v: u32 = counter;
        try stdout.print("{d}", .{v});
        rw.unlockShared();
        std.time.sleep(std.time.ns_per_s * 2);
    }
}

fn writer(rw: *thread.RwLock) void {
    while(true) {
        rw.lock();
        counter += 1;
        rw.unlock();
        std.time.sleep(std.time.ns_per_s * 2);
    }
}

pub fn main() !void {
    var lock: thread.RwLock = .{};
    const t1 = try thread.spawn(.{}, reader, .{&lock});
    const t2 = try thread.spawn(.{}, reader, .{&lock});
    const t3 = try thread.spawn(.{}, reader, .{&lock});
    const t4 = try thread.spawn(.{}, writer, .{&lock});

    t1.join();
    t2.join();
    t3.join();
    t4.join();

}
