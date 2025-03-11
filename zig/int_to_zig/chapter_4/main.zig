const std = @import("std");
const base64 = @import("Base64.zig");

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var memmory_buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&memmory_buffer);
    const allocator = fba.allocator();

    const text = "Testing some more stuff";
    const etext = "";
}
