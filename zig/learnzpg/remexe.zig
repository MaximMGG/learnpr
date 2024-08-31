const std = @import("std");
const c = std.c;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const userName: []u8 = try allocator.alloc(u8, 512);
    const us: [*]u8 = &userName;
    defer allocator.free(userName);
    c.getcwd(us, 512);

    std.debug.print("User name is {?s}\n", .{userName});
}
