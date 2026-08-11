const std = @import("std");
var stdout: *std.Io.Writer = undefined;


fn check_extension(file_name: []const u8) bool {
    const sh = std.mem.lastIndexOfLinear(u8, file_name, ".sh");
    if (sh) |_| {
        return false;
    } else {
        return true;
    }
}

fn print_level(level: i32) !void {
    for (0..@as(usize, @intCast(level))) |_| {
        try stdout.print(" ", .{});
    }
}

fn iterate_throuth_dir(allocator: std.mem.Allocator, dir: std.Io.Dir, path: []const u8, io: std.Io, level: i32) !void {
    var it = dir.iterate();
    try print_level(level);
    try stdout.print("Scanning {s}\n", .{path});

    while(try it.next(io)) |entry| {
        switch(entry.kind) {
            .directory => {
                if (entry.name[0] == '.') {
                    continue;
                }

                var sub_dir = try dir.openDir(io, entry.name, .{.iterate = true});
                defer sub_dir.close(io);
                const new_path = try std.mem.concat(allocator, u8, &[_][]const u8{path,"/", entry.name});
                defer allocator.free(new_path);
                try iterate_throuth_dir(allocator, sub_dir, new_path, io, level + 1);
            },
            .file => {
                const f = try dir.openFile(io, entry.name, .{ .mode =  .read_only});
                const stat = try f.stat(io);
                const mode = stat.permissions.toMode();

                if ((mode & 0o111) != 0) {
                    if (check_extension(entry.name)) {
                        try print_level(level);
                        try stdout.print("\x1b[2;31mDeleting executable {s}\x1b[0m\n", .{entry.name});
                        try dir.deleteFile(io, entry.name);
                    }
                }                 
            },
            else => {continue;}
        }
    }
}



pub fn main(init: std.process.Init) !void {

    var buf: [1024]u8 = undefined;
    var f_stdout = std.Io.File.stdout().writer(init.io, &buf);
    stdout = &f_stdout.interface;


    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    const c_allocator = std.heap.c_allocator;

    var cwd = try std.Io.Dir.cwd().openDir(init.io, ".", .{.iterate = true});
    defer cwd.close(init.io);
    //try iterate_throuth_dir(allocator, cwd, ".");
    try iterate_throuth_dir(c_allocator, cwd, ".", init.io, 0);

    try stdout.flush();
}
