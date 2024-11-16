const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    try test_main(gpa.allocator());
}

fn test_main(aloc: std.mem.Allocator) !void {
    var list = std.ArrayList(u8).init(aloc);
    defer list.deinit();

    for ("Hello, world!") |byte| try list.append(byte);
    printList(list);

    try list.append('\n');
    printList(list);
    _ = list.pop();
    printList(list);

    const writer = list.writer();
    _ = try writer.print(" Writing to an ArrayList: {}", .{42});
    printList(list);

    while (list.popOrNull()) |byte| print("{c} ", .{byte});
    print("\n\n", .{});
    printList(list);

    try list.appendSlice("Hello, world!");
    printList(list);

    _ = list.orderedRemove(5);
    printList(list);

    _ = list.swapRemove(5);
    printList(list);

    list.items[5] = ' ';
    printList(list);

    const slice = try list.toOwnedSlice();
    defer aloc.free(slice);
    printList(list);

    list = try std.ArrayList(u8).initCapacity(aloc, 12);

    for ("Hello") |byte| list.appendAssumeCapacity(byte);
    print("len: {}, cap: {}\n", .{ list.items.len, list.capacity });
    printList(list);

    const bytes = try getherBytes(aloc, "Hey there!");
    defer aloc.free(bytes);

    print("bytes: {s}\n", .{bytes});
}

fn printList(list: std.ArrayList(u8)) void {
    print("list: ", .{});
    for (list.items) |item| print("{c} ", .{item});
    print("\n\n", .{});
}

fn getherBytes(alloctor: std.mem.Allocator, slice: []const u8) ![]u8 {
    var list = try std.ArrayList(u8).initCapacity(alloctor, slice.len);
    defer list.deinit();
    for (slice) |byte| list.appendAssumeCapacity(byte);
    return try list.toOwnedSlice();
}

test "ArrayListTest" {
    try test_main(std.testing.allocator);
}
