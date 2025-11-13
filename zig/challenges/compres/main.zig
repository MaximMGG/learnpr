const std = @import("std");

const FILE = "test.txt";

pub fn main() !void {

    const allocator = std.heap.page_allocator;

    var tree = std.AutoHashMap(u8, i32).init(allocator);
    defer tree.deinit();
    var buf: u8[1024] = undefined;

    var stdout_writer = std.fs.File.stdout().writer(&buf);
    var stdout = &stdout_writer.interface;


    const file = try std.fs.cwd().openFile(FILE, .{.mode = .read_only});
    defer file.close();
    const file_stat = try file.stat();
    var file_reader = file.reader(&buf);
    const reader = &file_reader.interface;

    const file_buf = try reader.readAlloc(allocator, file_stat.size);
    defer allocator.free(file_buf);

    for(0..file_buf.len) |i| {
        if (tree.getEntry(file_buf[i])) |entry| {
            entry.value_ptr.* += 1;
        } else {
            tree.put(file_buf[i], 1);
        }
    }

    var it = tree.iterator();

    while(it.next()) |entry| {
        stdout.print("Char: {c} - Value: {d}\n", .{entry.key_ptr.*, entry.value_ptr.*});
    }
}
