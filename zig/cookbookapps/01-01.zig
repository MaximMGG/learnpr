const std = @import("std");

pub fn main() !void {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const alc = gpa.allocator();

    const f = try std.fs.cwd().openFile("test2.txt", .{});
    const reader = f.reader();

    var buf: [512:0]u8 = .{0} ** 512;
    var i: usize = 0;
    const writer = std.io.bufferedWriter();
    writer.buf = buf;

    while (reader.streamUntilDelimiter(writer, &buf, 512)) : (i += 1) {
        std.debug.print("{d} - {s}", .{ i, buf });
        @memset(&buf, 0);
    } else |err| switch (err) {
        .NoEofError => {},
    }
}
