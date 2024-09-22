const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();
    var list = std.ArrayList([:0]const u8).init(alc);
    defer list.deinit();

    const msg: [:0]const u8 = "hello";
    var buf: [512:0]u8 = .{0} ** 512;

    try list.append(msg);

    const f = try std.fs.cwd().openFile("packet_struct.zig", .{});
    defer f.close();
    const reader = f.reader();
    _ = try reader.readUntilDelimiter(&buf, '\n');

    std.debug.print("{s}\n", .{buf});

    for (list.items) |i| {
        std.debug.print("{s}\n", .{i});
    }
}
