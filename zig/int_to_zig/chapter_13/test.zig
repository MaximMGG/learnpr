const std = @import("std");


pub fn main() !void {

    var buf_for_fix: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(buf_for_fix[0..]);
    const allocator = fba.allocator();

    const fname = "dirmain.zig";

    var buf: [128]u8 = undefined;
    const cwd_buf = try std.posix.getcwd(buf[0..]);

    const full_path = try std.mem.concat(allocator, u8, &[_][]const u8 {cwd_buf, "/", fname});
    std.debug.print("Full path: {s}\n", .{full_path});
    defer allocator.free(full_path);
    const f = try std.fs.openFileAbsolute(full_path, .{.mode = .read_only});


    var f_buf: [1024]u8 = undefined;

    const f_reader = f.reader();
    _ = try f_reader.readAll(f_buf[0..]);

    std.debug.print("{s}\n", .{f_buf});


}
