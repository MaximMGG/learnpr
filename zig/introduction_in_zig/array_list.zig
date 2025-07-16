const std = @import("std");



pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var list = try std.ArrayList(u8).initCapacity(allocator, 100);
    defer list.deinit();

    try list.append('H');
    try list.append('e');
    try list.append('l');
    try list.append('l');
    try list.append('o');

    try list.appendSlice(" World!");


    std.debug.print("{s}\n", .{list.items});
}
