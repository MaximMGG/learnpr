const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();

    // const dir = std.fs.cwd();
    // const thisdir = try dir.openDir("../", .{ .iterate = true });
    // var it = thisdir.iterate();
    // while (try it.next()) |e| {
    //     std.debug.print("file name -> {s}\n", .{e.name});
    // }
    const path = "../";
    try print_dir(path, alc);
}

pub fn print_dir(path: []const u8, alc: std.mem.Allocator) !void {
    std.debug.print("Entry func with path {s}\n", .{path});
    const dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
    var it = dir.iterate();

    std.debug.print("<<<DIR: {s}>>>\n", .{path});
    while (try it.next()) |e| {
        if (e.kind == .directory) {
            var buf = try alc.alloc(u8, 512);
            @memset(buf[0..512], 0);
            _ = try std.posix.getcwd(buf);
            std.debug.print("{s}\n", .{buf});
            std.mem.copyForwards(u8, buf[std.mem.len(@as([*:0]u8, @ptrCast(buf)))..], "/");
            std.mem.copyForwards(u8, buf[std.mem.len(@as([*:0]u8, @ptrCast(buf)))..], e.name);

            try print_dir(e.name, alc);
        } else {
            std.debug.print("File name: {s}\n", .{e.name});
        }
    }
}
