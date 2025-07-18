const std = @import("std");
const c = @cImport({
    @cDefine("_NO_CRT_STDIO_INLINE", "1");
    @cInclude("stdio.h");
    @cInclude("spng.h");
});

fn get_png_header(ctx: *c.spng_ctx) !c.spng_ihdr {
    var image_header: c.spng_ihdr = undefined;
    if (c.spng_get_ihdr(ctx, &image_header) != 0) {
        return error.CouldNotGetImageHeader;
    }

    return image_header;

}

fn calc_output_size(ctx: *c.spng_ctx) !u64 {
    var output_size: u64 = 0;
    const status = c.spng_decoded_image_size(ctx, c.SPNG_FMT_RGBA8, &output_size);
    if (status != 0) {
        return error.CouldNotCalcOutputSize;
    }

    return output_size;

}

fn read_data_to_buffer(ctx: *c.spng_ctx, buffer: []u8) !void {
    const status = c.spng_decode_image(ctx, @ptrCast(buffer.ptr), buffer.len, c.SPNG_FMT_RGBA8, 0);
    if (status != 0) {
        return error.CouldNotReadDataToBuffer;
    }
}

fn applay_image_filter(buffer: []u8) !void {
    const len = buffer.len;
    const red_factor: f16 = 0.2126;
    const green_factor: f16 = 0.7152;
    const blue_factor: f16 = 0.0722;
    var index: u64 = 0;
    while(index < len) : (index += 4) {
        const rf: f16 = @floatFromInt(buffer[index]);
        const gf: f16 = @floatFromInt(buffer[index + 1]);
        const bf: f16 = @floatFromInt(buffer[index + 2]);
        const y_linear: f16 = (rf * red_factor) + (gf * green_factor) + (bf * blue_factor);
        buffer[index] = @intFromFloat(y_linear);
        buffer[index + 1] = @intFromFloat(y_linear);
        buffer[index + 2] = @intFromFloat(y_linear);
    }
}

fn save_png(image_header: *c.spng_ihdr, buffer: []u8) !void {
    const path = "pedro_pascal_filter.png";
    const file = c.fopen(path, "wb");
    if (file == null) {
        return error.CouldNotOpenFile;
    }
    const ctx = c.spng_ctx_new(c.SPNG_CTX_ENCODER) orelse unreachable;
    defer c.spng_ctx_free(ctx);
    _ = c.spng_set_png_file(ctx, @ptrCast(file));
    _ = c.spng_set_ihdr(ctx, image_header);

    const encode_status = c.spng_encode_image(ctx, 
                    @ptrCast(buffer.ptr), buffer.len, c.SPNG_FMT_PNG, c.SPNG_ENCODE_FINALIZE);
    if (encode_status != 0) {
        return error.CouldNotEncodeImage;
    }
    if (c.fclose(file) != 0) {
        return error.CouldNotCloseFile;
    }

}

pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();


    const path = "pedro_pascal.png";
    const file = c.fopen(path, "rb");
    defer _ = c.fclose(file);

    if (file == null) {
        @panic("Con't open file");
    }

    const ctx = c.spng_ctx_new(0) orelse unreachable;
    defer c.spng_ctx_free(ctx);

    _ = c.spng_set_png_file(ctx, @ptrCast(file));

    var image_header = try get_png_header(ctx);
    _ = &image_header;

    const output_size = try calc_output_size(ctx);
    var buffer = try allocator.alloc(u8, output_size);
    defer allocator.free(buffer);
    @memset(buffer[0..], 0);

    try read_data_to_buffer(ctx, buffer);
    try applay_image_filter(buffer);

    try save_png(&image_header, buffer);

}
