const std = @import("std");

pub fn main() !void {
//    const alloc = std.heap.page_allocator; 
    const cur_dir = std.fs.cwd();
    const f: std.fs.File = try cur_dir.openFile("reflect.zig", .{.mode = .read_only});
    var buf: [1024:0]u8 = undefined;
    const readbytes: usize = try f.read(&buf);

    std.debug.print("{read bytes is: {d}\n}", .{readbytes});
    std.debug.print("{s}\n", .{buf});

    defer f.close();

}
