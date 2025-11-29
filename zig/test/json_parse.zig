const std = @import("std");
const json = std.json;

var buf: [4096]u8 = undefined;


const Tokens = struct {
    tokens: [][]const u8,
};


fn getWriter(name: []const u8) !*std.Io.Writer {
    const file = try std.fs.cwd().openFile(name, .{.mode = .write_only});
    var file_writer = file.writer(&buf);
    return &file_writer.interface;
}

fn readJsonFile(allocator: std.mem.Allocator, name: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(name, .{.mode = .read_only});
    defer file.close();
    const file_stat = try file.stat();
    const json_buf = try allocator.alloc(u8, file_stat.size);
    const read_bytes = try file.readAll(json_buf);
    if (read_bytes != file_stat.size) {
        std.debug.print("raed bytes: {d}, file_stat.size: {d}\n", .{read_bytes, file_stat.size});
        unreachable;
    }
    return json_buf;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var list = try std.ArrayList([]const u8).initCapacity(allocator, 4);
    defer list.deinit(allocator);
    const json_file = try readJsonFile(allocator, "./config.json");
    defer allocator.free(json_file);

    const t = try json.parseFromSlice(Tokens, allocator, json_file, .{});
    for(t.value.tokens) |token| {
        std.debug.print("{s}\n", .{token});
        try list.append(allocator, token);
    }

    try list.append(allocator, "LTCUSDT");

    const new_t: Tokens = .{.tokens = list.items};

    var st = json.Stringify{.writer = try getWriter("./config.json")};
    try st.write(new_t);
}

