const std = @import("std");



pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var list = try std.ArrayList(u32).initCapacity(allocator, 100);
    list.items.len = list.capacity;
    defer list.deinit();

    for(list.items, 0..list.capacity) |*item, i| {
        //try list.append(@as(u32, @intCast(i + 123)));
        item.* = @as(u32, @intCast(i + 111));
        list.items.len += 1;
    }


    for(list.items) |i| {
        std.debug.print("{d}\n", .{i});
    }
}
