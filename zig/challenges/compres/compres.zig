const std = @import("std");

pub fn main() !void {
    var errbuf: [4096]u8 = .{0} ** 4096;
    var stderr_writer = std.fs.File.stderr().writer(&errbuf);
    var stderr = stderr_writer.interface;
    const allocator = std.heap.page_allocator;
    var map = std.AutoHashMap(u8, u32).init(allocator);
    defer map.deinit();

    const file = try std.fs.cwd().openFile("test.txt", .{ .mode = .read_only });
    var reader_buf: [4096]u8 = undefined;
    var f_reader = file.reader(&reader_buf);
    defer file.close();

    const fstat = try file.stat();
    const read_bytes = try f_reader.interface.readAlloc(allocator, fstat.size);
    defer allocator.free(read_bytes);

    for (read_bytes) |c| {
        if (!map.contains(c)) {
            try map.put(c, @intCast(1));
        } else {
            const kv = map.getEntry(c).?;
            kv.value_ptr.* += 1;
        }
    }

    var total: u64 = 0;
    var it = map.iterator();
    while (it.next()) |i| {
        try stderr.print("Key - {c}, value - {d}\n", .{ i.key_ptr.*, i.value_ptr.* });
        total += i.value_ptr.*;
    }

    try stderr.print("File size {d}, total chars {d}\n", .{ fstat.size, total });
    _ = &stderr_writer;
}
