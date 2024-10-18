const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(gpa.deinit() == .ok);

    const aloc = gpa.allocator();

    const u32_ptr = try aloc.create(u32);
    u32_ptr.* = 123123;
    // _ = u32_ptr;

    std.debug.print("{d}\n", .{u32_ptr.*});
    aloc.destroy(u32_ptr);
}
