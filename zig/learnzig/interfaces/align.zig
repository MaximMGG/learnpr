const std = @import("std");

pub fn main() void {
    std.debug.print("{any}\n", .{@alignOf(file)});
    std.debug.print("{any}\n", .{@alignOf(anyopaque)});
}

const file = struct { ptr: *anyopaque, a: i32, seek: u32 };
