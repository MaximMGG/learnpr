const std = @import("std");
const List = @import("list.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var list = List.List(u32).init(allocator);
    !list.append(123123);
}
