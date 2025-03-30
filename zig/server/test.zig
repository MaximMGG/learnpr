const std = @import("std");

const User = struct {
    name: []const u8,
    age: u32,
    phone: []const u8,

};


pub fn main() !void {

    const allocator = std.heap.c_allocator;


    const u = User{.name = "Pedro", .age = 22, .phone = "+3812122313"};
    const s = try std.json.stringifyAlloc(allocator, u, .{});
    std.debug.print("{s}\n", .{s});
    allocator.free(s);

}
