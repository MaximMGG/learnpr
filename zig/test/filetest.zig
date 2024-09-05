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
    const path = "..";
    if (!std.mem.startsWith(u8, path, "/")) {
        var buf: [512]u8 = .{0} ** 512;
        _ = try std.posix.getcwd(&buf);
        try print_dir(&buf, alc);
    } else {
        try print_dir(path, alc);
    }
}

pub fn print_dir(path: []const u8, alc: std.mem.Allocator) !void {
    std.debug.print("Entry func with path {s}\n", .{path});
    const dir = try std.fs.openDirAbsolute(path, .{ .iterate = true });
    var it = dir.iterate();

    std.debug.print("<<<DIR: {s}>>>\n", .{path});
    while (try it.next()) |e| {
        if (e.kind == .directory) {
            var _p: [512]u8 = .{0} ** 512;
            @memcpy(_p[0.._p.len], path[0..path.len]);
            std.mem.copyForwards(u8, _p[std.mem.len(@as([*:0]u8, @ptrCast(&_p))).._p.len], "/");
            std.mem.copyForwards(u8, _p[std.mem.len(@as([*:0]u8, @ptrCast(&_p))).._p.len], e.name);
            try print_dir(path, alc);
        } else {
            std.debug.print("File name: {s}\n", .{e.name});
        }
    }
}
