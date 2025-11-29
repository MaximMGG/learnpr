const std = @import("std");
const c = @cImport({
    @cInclude("openssl/ssl.h");
    @cInclude("openssl/err.h");
    @cInclude("ncurses.h");
});


const Tokens = struct {
    tokens: [][]u8
};


pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const json_file = try std.fs.cwd().openFile("./config.json", .{.mode = .read_only});
    const json_file_stat = try json_file.stat();
    const buf: []u8 = try allocator.alloc(u8, json_file_stat.size);
    defer allocator.free(buf);

    const read_bytes = try json_file.readAll(buf);
    if (read_bytes != json_file_stat.size) {
        std.debug.print("Read bytes {d} not equealse file size {d}\n", .{read_bytes, json_file_stat.size});
        return;
    }

    const t = try std.json.innerParse(Tokens, allocator, buf, .{});

}
