const std = @import("std");
const base64 = @import("Base64.zig");

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var memmory_buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&memmory_buffer);
    const allocator = fba.allocator();

    const text = "Testing some more stuff";
    const etext = "VGVzdGluZyBzb21lIG1vcmUgc3R1ZmY=";
    const b64 = base64.Base64.init();
    const encoded_text = b64.encode(allocator, text);
    const decoded_text = b64.decode(allocator, encoded_text);

    try stdout.print("Basic text: {s}\n", .{text});
    try stdout.print("Basic etext: {s}\n", .{etext});
    try stdout.print("Encoded text: {s}\n", .{encoded_text});
    try stdout.print("Decoded text: {s}\n", .{decoded_text});
}
