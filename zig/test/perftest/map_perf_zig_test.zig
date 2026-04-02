const std = @import("std");

var stdout: *std.Io.Writer = undefined;

fn increment_key(key: []u8) bool {

    var i = key.len - 1;

    while(true) {
        if (key[i] < '9') {
            key[i] += 1;
            break;
        } else {
            key[i] = '0';
            i -= 1;
            continue;
        }
    }

    if (key[3] == '1') {
        return false;
    }
    return true;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var buf: [4096]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&buf);
    stdout = &stdout_writer.interface;
    const def_key = try allocator.dupe(u8, "Key000000");
    defer allocator.free(def_key);

    var map = std.StringHashMap(i32).init(allocator);
    defer map.deinit();
    var idx: i32 = 1;
    while(increment_key(def_key)) {
        const k = try allocator.alloc(u8, def_key.len);
        @memcpy(k, def_key);
        //std.mem.copyForwards(u8, k, def_key);
        try map.put(k, idx);
        idx += 1;
    }

    var it = map.iterator();

    var count: u64 = 0;
    while(it.next()) |entry| {
        try stdout.print("Key -> {s}, val -> {d}\n", .{entry.key_ptr.*, entry.value_ptr.*});
        allocator.free(entry.key_ptr.*);
        count += 1;
    }
    std.debug.print("Total elements: {d}\n", .{count});
    try stdout.flush();
}
