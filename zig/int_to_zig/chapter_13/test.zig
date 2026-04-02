const std = @import("std");


pub fn main() !void {

    var buf_for_fix: [4096]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(buf_for_fix[0..]);
    const allocator = fba.allocator();

    const fname = "dirmain.zig";

    var buf: [128]u8 = undefined;
    const cwd_buf = try std.posix.getcwd(buf[0..]);

    const full_path = try std.mem.concat(allocator, u8, &[_][]const u8 {cwd_buf, "/", fname});
    std.debug.print("Full path: {s}\n", .{full_path});
    defer allocator.free(full_path);
    const f = try std.fs.openFileAbsolute(full_path, .{.mode = .read_only});
    const file_stat = try f.stat();
    const f_size = @as(usize, @intCast(file_stat.size));
    std.debug.print("File size = {d}\n", .{f_size});

    var f_buf: [1024]u8 = undefined;

    const f_reader = f.reader();
    var read_bytes: usize = 0;
    while(read_bytes < f_size) {
        read_bytes += try f_reader.readAll(f_buf[0..]);
        std.debug.print("{s}", .{f_buf});
        @memset(f_buf[0..], 0);
    }


    const cwd = std.fs.cwd();
    cwd.access("super.txt", .{.mode = .read_only}) catch |err| {
        switch(err) {
            error.FileNotFound => {
                std.debug.print("File super.txt doesn't exists - {any}\n", .{err});
            },
            else => {}
        }
    };

    const main_buf = try cwd.readFileAlloc(allocator, "main.zig", 2048);
    defer allocator.free(main_buf);

    std.debug.print("{s}", .{main_buf});





}
