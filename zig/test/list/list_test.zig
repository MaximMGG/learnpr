const std = @import("std");
const list = @import("list.zig");


pub fn main() !void {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    const c_alloc = std.heap.c_allocator;

    // var l = list.List(u32).init(allocator);
    var l = list.List(u32).init(c_alloc);
    defer l.deinit();

    for(0..42) |i| {
        try l.append(@as(u32, @intCast(i)));
    }

    for(l.items) |item|{
        std.debug.print("{d}\n", .{item});
    }
    std.debug.print("\n\n", .{});

    var arr = [_]u32{3, 88, 12, 74, 9999, 3, 8, 1, 28 ,3, 12, 9499, 1238, 848, 1, 0, 0, 2, 34, 1, 284, 12, 4, 28, 44, 12, 949, 128, 1111111, 9281, 1231, 3535, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 43, 4, 5, 777777777};
    try l.appendSlice(&arr);

    for(l.items) |item|{
        std.debug.print("{d}\n", .{item});
    }
    std.debug.print("{any}\nItems.len = {d}\n", .{l.items, l.items.len});
    
}
