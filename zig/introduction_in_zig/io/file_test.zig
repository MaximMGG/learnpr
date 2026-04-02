const std = @import("std");


pub fn main() !void {
    const f = try std.fs.cwd().openFile("test1.zig", .{.mode = .read_write});
    
    try f.seekFromEnd(0);
    const file_size = try f.getPos();

    const f_writer = f.writer();

    try f_writer.writeAll("\n//New commend under cod\n");

    std.debug.print("File size: {d}\n", .{file_size});
}
