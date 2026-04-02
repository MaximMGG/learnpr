const std = @import("std");
const stdout = std.io.getStdOut().writer();
const thread = std.Thread;

fn print_id(id: *const u8) void {
    stdout.print("Thread ID: {d}\n", .{id.*}) catch {};
}


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const id1: u8 = 1;
    const id2: u8 = 2;

    const opt = thread.Pool.Options{.n_jobs = 4, .allocator = allocator};
    var pool: thread.Pool = undefined;
    try pool.init(opt);
    defer pool.deinit();

    try pool.spawn(print_id, .{&id1});
    try pool.spawn(print_id, .{&id2});

    try stdout.print("Finish main\n", .{});
}

