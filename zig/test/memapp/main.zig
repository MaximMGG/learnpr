const std = @import("std");


const test_file = "test.txt";

//dog in box: пес в коробке
fn pars_file(allocator: std.mem.Allocator, file_name: []const u8, map: *std.StringHashMap([]u8)) !void {
    const file = try std.fs.cwd().openFile(file_name, .{.mode = .read_only});
    const file_stat = try file.stat();
    defer file.close();

    const buf = try allocator.alloc(u8, file_stat.size);
    defer allocator.free(buf);
    const read_bytes = try file.readAll(buf);
    if (read_bytes != buf.len) {
        @panic("read_bytes not equal buf.size");
    }
    var left_p: usize = 0;
    var right_p: usize = 0;
    while(left_p < buf.len) {
         right_p += std.mem.indexOfScalar(u8, buf[left_p..buf.len], ':') orelse break;
         const k = try allocator.dupe(u8, buf[left_p..(right_p)]);
         left_p = right_p + 2;
         right_p += 2;
         right_p += std.mem.indexOfScalar(u8, buf[left_p..buf.len], '\n') orelse {
             allocator.free(k);
             break;
         };
         const v = try allocator.dupe(u8, buf[left_p..(right_p)]);
         try map.put(k, v);
         left_p = right_p + 1;
         right_p += 1;
    }
}

fn map_free(allocator: std.mem.Allocator, map: std.StringHashMap([]u8)) void {
    var it = map.iterator();
    while(it.next()) |entry| {
        allocator.free(entry.key_ptr.*);
        allocator.free(entry.value_ptr.*);
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var map = std.StringHashMap([]u8).init(allocator);
    defer map.deinit();

    try pars_file(allocator, test_file, &map);

    var it = map.iterator();
    while(it.next()) |entry| {
        std.debug.print("{s} - {s}\n", .{entry.key_ptr.*, entry.value_ptr.*});
    }
    map_free(allocator, map);
}
