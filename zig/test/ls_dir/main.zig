const std = @import("std");

const stdout = std.io.getStdOut().writer();

fn Traverse(path: []const u8) !void {
    try stdout.print("Traverse path: {s}\n", .{path});
    var dir = try std.fs.openDirAbsolute(path, .{ .iterate = true });
    defer dir.close();

    var dir_it = dir.iterate();

    var buf: [1024]u8 = undefined;
    @memset(buf[0..1024], 0);

    while (try dir_it.next()) |file| {
        //try stdout.print("File -> {s}\n", .{file.name});
        const full_path = try std.fmt.bufPrint(buf[0..], "{s}/{s}", .{ path, file.name });
        std.fs.File.OpenFlags;
        std.fs.accessAbsolute(full_path, .{ .mode = .write_only }) catch |e| {
            switch (e) {
                std.fs.Dir.AccessError.FileNotFound => {
                    try stdout.print("File not found\n", .{});
                },
                std.fs.Dir.AccessError.InputOutput => {
                    try stdout.print("IO error", .{});
                },
                else => {
                    try stdout.print("Some one else", .{});
                },
            }
        };
        try stdout.print("Can read {s}\n", .{full_path});
        //try stdout.print("Cant read {s}\n", .{full_path});
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const args: [][:0]u8 = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    var cwd: [1024]u8 = .{0} ** 1024;

    const cwd_path = try std.posix.getcwd(cwd[0..cwd.len]);

    if (args.len == 1) {
        try Traverse(cwd_path);
    } else {
        if (std.mem.startsWith(u8, args[1], "/")) {
            try Traverse(args[1]);
        } else {
            const full_path = try std.mem.concat(allocator, u8, &[_][]const u8{ cwd_path, "/", args[1] });
            defer allocator.free(full_path);
            try Traverse(full_path);
        }
    }
}
