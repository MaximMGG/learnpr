const std = @import("std");
const Base64 = @import("base64.zig").Base64;

const stdout = std.io.getStdOut().writer();



pub fn main() !void {
    var mem_buf: [1000] u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&mem_buf);
    const allocator = fba.allocator();

    const text = "Testing some more stuff";
    const etext = "VGVzdGluZyBzb21lIG1vcmUgc3R1ZmY=";
    const base64 = Base64.init();
    const encoded_text = try base64.encode(text, allocator);
    const decoded_text = try base64.decode(etext, allocator);
    const decoded_encoded_text = try base64.decode(encoded_text, allocator);


    try stdout.print("Encoded text: {s}\n", .{encoded_text});
    try stdout.print("etext: {s}\n", .{etext});
    try stdout.print("Decoded text: {s}\n", .{decoded_text});
    try stdout.print("Encoded length: {d}\n", .{encoded_text.len});
    try stdout.print("Decoded length: {d}\n", .{encoded_text.len});


    try stdout.print("Decoded encoded text: {s}\n", .{decoded_encoded_text});



}
