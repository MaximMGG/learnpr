const std = @import("std");
var errbuf: [4096]u8 = .{0} ** 4096;
const stderr = std.fs.File.stderr().writer(&errbuf).initInterface(&errbuf);

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var map = std.AutoHashMap(u8, u32).init(allocator);
    defer map.deinit();

    const file = try std.fs.cwd().openFile("test.txt", .{ .mode = .read_only });
    defer file.close();

    const fstat = try file.stat();
    const buf = try allocator.alloc(u8, fstat.size);
    defer allocator.free(buf);
    const read_bytes = try file.readAll(buf);
    if (fstat.size != read_bytes) {
        @panic("read_bytes != fstat.size");
    }

    for (buf) |c| {
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
        stderr.print("Key - {c}, value - {d}\n", .{ i.key_ptr.*, i.value_ptr.* });
        total += i.value_ptr.*;
    }

    stderr.print("File size {d}, total chars {d}\n", .{ fstat.size, total });
}
