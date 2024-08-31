const std = @import("std");
const cc = @cImport(@cInclude("string.h"));
const c = std.c;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const userName: []u8 = try allocator.alloc(u8, 512);
    defer allocator.free(userName);

    _ = cc.memset(userName.ptr, 0, 512);
    // @memset(userName, 0);
    _ = c.getcwd(userName.ptr, 512);

    std.debug.print("User name is {?s}\n", .{userName});
}
