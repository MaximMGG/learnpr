const std = @import("std");
const png = @cImport(@cInclude("libpng16/png.h"));
const spng = @cImport(@cInclude("spng.h"));



pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const png_file = try std.fs.cwd().openFile("Simple_cat.png", .{.mode = .read_only});
    defer png_file.close();
    var buf: [4096]u8 = undefined;
    var reader = png_file.reader(&buf);
    const stat = try png_file.stat();

    const file_buf = try reader.interface.readAlloc(allocator, stat.size);
    defer allocator.free(file_buf);


    std.debug.print("File buf length: {d}\n", .{file_buf.len});

    std.debug.print("First 128 bytes: {any}\n\n", .{file_buf[0..129]});

    std.debug.print("First 8 bytes: {any}\n", .{file_buf[0..8]});

    std.debug.print("Length: {any}, Chunk Type: {s}\n", .{file_buf[8..12], file_buf[12..16]});


    const length_buf = file_buf[8..12];
    var len: u32 = 0;
    len = len | length_buf[0];
    len <<= 8;
    len = len | length_buf[1];
    len <<= 8;
    len = len | length_buf[2];
    len <<= 8;
    len = len | length_buf[3];
    //const length: *u32 = @ptrCast(@alignCast(file_buf[8..12].ptr));
    const length: *u32 = @ptrCast(@alignCast(file_buf[8..12]));
    const length_little = std.mem.bigToNative(u32, length.*);
    std.debug.print("Length from pointer: {d}\n", .{length.*});
    std.debug.print("Length from pointer in Hex: 0x{X}\n", .{length.*});
    std.debug.print("Length after shifting: {d}\n", .{len});
    std.debug.print("Length after convertiong ot native: {d}\n", .{length_little});

    //std.debug.print("Length in decimal: {d}\n", .{try std.fmt.parseUnsigned(u32, file_buf[8..12], 10)});
}
