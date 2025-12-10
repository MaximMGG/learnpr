const std = @import("std");


pub fn main() !void {
    var buf: [4096]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&buf);
    const stdout = &stdout_writer.interface;
    try stdout.print("Begin\n", .{});

    const allocator = std.heap.page_allocator;

    var map = std.AutoHashMap(i32, u64).init(allocator);
    defer map.deinit();

    var key: i32 = 1;
    var val: u64 = 3;
    var count: u32 = 1_000_000;

    while(count != 0) {
        try map.put(key, val);
        key += 1;
        val += 123;

        count -= 1;
    }

    var it = map.iterator();
    var total_sum: u64 = 0;
    while(it.next()) |entry| {
        total_sum += entry.value_ptr.*;
    }
    try stdout.print("Total sum is: {d}\n", .{total_sum});
    try stdout.flush();
}
