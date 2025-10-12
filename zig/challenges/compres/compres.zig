const std = @import("std");

const Node = struct {
    weight: u32 = 0,
    val:    u8 = 0,
    leaf:   bool = false,
    left:   ?*Node = null,
    right:  ?*Node = null,
};

const Pair = struct {
    char: u8,
    count: u32,
};


fn compare(context: u32, a: u32, b: u32) std.math.Order {
    _ = context;
    
    if (a == b) return .eq;
    if (a < b) return .lt;
    if (a > b) return .gt;
}

pub fn main() !void { 
    const allocator = std.heap.page_allocator;
    const q = std.PriorityQueue(u32, u32, compare).init(allocator, u32);

    try q.add(123);
    try q.add(13);
    try q.add(12834);
    try q.add(11);


    std.debug.print("{d}\n", .{q.peek().?});
    std.debug.print("{d}\n", .{q.peek().?});
    std.debug.print("{d}\n", .{q.peek().?});
    std.debug.print("{d}\n", .{q.peek().?});


}
