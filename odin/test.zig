const std = @import("std");

fn getNum(x: u32) u32 {
    if (x % @as(u32, 2) == 0) {
        return x + @as(u32, 1);
    } else {
        return x;
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var aloc = gpa.allocator();
    var x = try aloc.alloc(i32, 3333333);
    defer aloc.free(x);

    for (0..3333333) |i| {
        x[i] = @intCast(i);
    }

    for (0..3333333) |i| {
        std.debug.print("{d}\n", .{x[i]});
    }
}
