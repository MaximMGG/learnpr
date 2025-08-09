const std = @import("std");



pub fn main() !void {
    var dir = try std.fs.cwd().openDir(".", .{.iterate = true});
    defer dir.close();

    std.debug.print("Directory {s} contain: \n", .{"."});

    var it = dir.iterate();
    while(try it.next()) |file| {
        if (file.kind == .directory) {
            std.debug.print("{s} is directory\n", .{file.name});
        } else {
            const f = try std.fs.cwd().openFile(file.name, .{.mode = .read_only});
            defer f.close();
            const stat = try f.stat();
            std.debug.print("{s} ({d} bytes)\n", .{file.name, stat.size});
        }

    }
}

