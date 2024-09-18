const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alc = gpa.allocator();
    // const arr = std.ArrayList([]u8).init(alc);
    // defer arr.deinit;

    // const writ = arr.writer();
    // _ = writ;
    const f = try std.fs.cwd().openFile("arr.c", .{});
    defer f.close();
    var buf: [512]u8 = .{0} ** 512;
    const read_bytes = try f.readAll(&buf);
    defer alc.free(buf);

    std.debug.print("{s}\n", .{buf});
    std.debug.print("read bytes is: {d}\n", .{read_bytes});
}
