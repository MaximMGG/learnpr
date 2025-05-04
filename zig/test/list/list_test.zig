const std = @import("std");
const list = @import("list.zig");


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var l = list.List(u32).init(allocator);
    defer l.deinit();

    for(0..10) |i| {
        try l.append(@as(u32, @intCast(i)));
    }

    for(l.items) |item|{
        std.debug.print("{d}\n", .{item});
    }
    
}
