const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var cwd_buf: [100]u8 = undefined;
    @memset(cwd_buf[0..], 0);

    const cwd_str = try std.posix.getcwd(cwd_buf[0..]);
    const cur = try std.fs.cwd().openDir(".", .{ .iterate = true });

    var it = cur.iterate();

    while (try it.next()) |entry| {
        const full_path = try std.mem.concat(allocator, u8, &[_][]const u8{ cwd_str, "/", entry.name });
        std.debug.print("{s}\n", .{full_path});

        const tmp_file = try std.fs.openFileAbsolute(full_path, .{ .mode = .read_only });
        defer tmp_file.close();
        const tmp_file_stat = try tmp_file.stat();

        switch (tmp_file_stat.kind) {
            .file => {
                if (tmp_file_stat.mode & std.posix.S.IXUSR > 0) {
                    std.debug.print("{s} - is executable\n", .{full_path});
                }
            },
            else => {
                std.debug.print("Some one else\n", .{});
            },
        }

        allocator.free(full_path);
    }
}
