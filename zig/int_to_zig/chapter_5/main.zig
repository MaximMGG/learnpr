const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const buf: []u8 = try allocator.alloc(u8, 100);
    @memset(buf, 0);
    defer allocator.free(buf);

    std.mem.copyForwards(u8, buf, "Hello world!");

    //std.debug.print("{s}\n", .{buf});
    print("{s}\n", .{buf});
}

fn print(comptime fmt: []const u8, args: anytype) void {
    const stderr = std.io.getStdErr().writer();
    stderr.print(fmt, args) catch |err| {
        switch (err) {
            else => {},
        }
        @panic("Somthing went wrong");
    };
}
