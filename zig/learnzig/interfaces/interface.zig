const std = @import("std");

pub fn main() !void {}

//simple interface
const Writer = struct {
    ptr: *anyopaque,
    writeAllFn: *const fn (ptr: *anyopaque, data: []const u8) anyerror!void,

    fn writeAll(self: Writer, data: []const u8) !void {
        return self.writeAllFn(self.ptr, data);
    }
};

const File = struct {
    fd: std.posix.fd_t,

    fn writeAll(ptr: *anyopaque, data: []const u8) !void {
        const self: File = @ptrCast(@alignCast(ptr));
        _ = try std.posix.write(self.fd, data);
    }

    fn writer(self: File) Writer {
        return .{ .ptr = self, .writeAllFn = writeAll };
    }
};
