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

    var key = [_]u8{'K', 'e', 'y', '0','0','0','0','0','0'};
    var val: i32 = 1;

    var m = std.StringHashMap(i32).init(allocator);
    defer m.deinit();

    while(increment_key(key[0..])) {
        try m.put(key[0..], val);
        val += 1;
    }

    var it = m.iterator();
    while(it.next()) |kv| {
        try stdout.print("Key -> {s}, Val -> {d}\n", .{kv.key_ptr.*, kv.value_ptr.*});
    }
}
