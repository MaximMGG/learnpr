const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();
    var walker = try std.fs.cwd().walk(alc);
    defer walker.deinit();

    while (try walker.next()) |f| {
        std.debug.print("{any}\n", .{f});
    }
}
