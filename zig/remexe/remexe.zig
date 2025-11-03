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


fn iterate_throuth_dir(allocator: std.mem.Allocator, dir: std.fs.Dir, path: []const u8) !void {
    var it = dir.iterate();
    try stdout.print("Scanning {s}\n", .{path});

    while(try it.next()) |entry| {
        switch(entry.kind) {
            .directory => {
                if (entry.name[0] == '.') {
                    continue;
                }

                var sub_dir = try dir.openDir(entry.name, .{.iterate = true});
                defer sub_dir.close();
                const new_path = try std.mem.concat(allocator, u8, &[_][]const u8{path,"/", entry.name});
                defer allocator.free(new_path);
                try iterate_throuth_dir(allocator, sub_dir, new_path);
            },
            .file => {
                const f = try dir.openFile(entry.name, .{});
                const m = try f.mode();
                if ((@as(u64, @intCast(m)) & std.posix.S.IXUSR) > 0) {
                    f.close();
                    if (check_extension(entry.name)) {
                        try stdout.print("Deleting executable {s}\n", .{entry.name});
                        try dir.deleteFile(entry.name);
                    }
                } else {
                    f.close();
                }
            },
            else => {continue;}
        }
    }
}



pub fn main() !void {

    var buf: [1024]u8 = undefined;
    var f_stdout = std.fs.File.stdout().writer(&buf);
    stdout = &f_stdout.interface;


    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    const c_allocator = std.heap.c_allocator;



    var cwd = try std.fs.cwd().openDir(".", .{.iterate = true});
    defer cwd.close();
    //try iterate_throuth_dir(allocator, cwd, ".");
    try iterate_throuth_dir(c_allocator, cwd, ".");

    try stdout.flush();
}
