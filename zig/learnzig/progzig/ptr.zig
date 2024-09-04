const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();

    var lookup = std.StringHashMap(*const User).init(alc);
    defer lookup.deinit();

    const goku = User{ .power = 666 };

    try lookup.put("Goku", &goku);

    const entry = lookup.get("Goku").?;

    std.debug.print("Goku's power is: {?d}\n", .{entry.power});

    _ = lookup.remove("Goku");

    std.debug.print("Goku's power is: {?d}\n", .{entry.power});
}

const User = struct { power: i32 };
