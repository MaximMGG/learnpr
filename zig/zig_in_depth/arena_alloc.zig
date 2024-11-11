const std = @import("std");

const List = @import("List_arena.zig").List;

pub fn main() !void {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // defer _ = gpa.deinit();
    // const alloc = gpa.allocator();
    const alloc = std.heap.page_allocator;
    const iterations: usize = 100;
    const item_count: usize = 1000;

    var timer = try std.time.Timer.start();

    for (0..iterations) |_| {
        var list = try List(usize).init(alloc, 13);
        errdefer list.deinit();

        for (0..item_count) |i| try list.append(i);

        list.deinit();
    }

    var took: f64 = @floatFromInt(timer.read());
    took /= std.time.ns_per_ms;

    std.debug.print("Took: {d:.2}ms\n", .{took});
}
