const std = @import("std");
const Thread = std.Thread;
const Pool = Thread.Pool;
const stdout = std.io.getStdOut().writer();

var num = std.atomic.Value(u32).init(0);

fn print_id(id: *const u8) void {
    _ = stdout.print("Thread id: {d}\n", .{id.*}) catch void;
}

fn add_one() void {
    num.store(num.load(.monotonic) + 1, .unordered);
}


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var pool: Pool = undefined;
    try pool.init(.{.allocator = allocator, .n_jobs = 4});
    defer pool.deinit();
    const id1: u8 = 1;
    const id2: u8 = 2;
    try pool.spawn(print_id, .{&id1});
    try pool.spawn(print_id, .{&id2});

    for(0..100) |_| {
        try pool.spawn(add_one, .{});
    }
    for(0..100) |_| {
        add_one();
    }
    try stdout.print("Num: {d}\n", .{num.load(.unordered)});
}

