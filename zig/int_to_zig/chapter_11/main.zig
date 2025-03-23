const std = @import("std");
const List = @import("list.zig");


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var arr = std.ArrayList(u8).init(allocator);
    defer arr.deinit();

    const c_alloc = std.heap.c_allocator;


    try arr.append('A');
    try arr.append('B');
    try arr.append('C');
    try arr.append('D');
    try arr.append('E');

    try arr.appendSlice(" and more letters");

    try arr.insert(3, 'D');

    try arr.insertSlice(6, "FFFFF");


    for(arr.items) |c| {
        std.debug.print("{c}\n", .{c});
    }

    std.debug.print("{s}\n", .{arr.items});


    var list = List.List(u32).init(c_alloc);
    defer list.deinit();
    try list.append(123);
    try list.append(124);
    try list.append(125);
    try list.append(126);

    std.debug.print("{d}\n", .{list.len});

    var tmp = list.head;

    while(tmp) |t| {
        std.debug.print("{d}\n", .{t.data});
        tmp = t.next;
    }
}
