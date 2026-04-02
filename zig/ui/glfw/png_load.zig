const std = @import("std");
const spng = @cImport(@cInclude("spng.h"));


pub extern "c" fn load_png_rgba8(png_name: [*c]const u8, png_len: *c_uint, width: *c_uint, height: *c_uint) [*c]u8;
pub extern "c" fn load_png_rgba8_upside(png_name: [*c]const u8, png_len: *c_uint, width: *c_uint, height: *c_uint) [*c]u8;

//image should frees with std.heap.c_allocator
pub fn load_png(png_name: []const u8, png_width: *u32, png_height: *u32) []u8 {
    var image: []u8 = undefined;
    var png_len: c_uint = 0;
    var width: c_uint = 0;
    var height: c_uint = 0;
    //image.ptr = @ptrCast(load_png_rgba8_upside(@ptrCast(png_name), &png_len, &width, &height));
    image.ptr = @ptrCast(load_png_rgba8(@ptrCast(png_name), &png_len, &width, &height));
    image.len = @intCast(png_len);

    png_width.* = @intCast(width);
    png_height.* = @intCast(height);
    return image;
}


test "load_png_rgba8 test" {
    var image: []u8 = undefined;
    var png_len: c_uint = 0;
    const png_name = "./res/textures/file.png";
    image.ptr = @ptrCast(load_png_rgba8(png_name, &png_len));
    image.len = @intCast(png_len);

    var start: usize = 0;
    var end: usize = 4;

    while(end < image.len) {
        const chunk = image[start..end];
        std.debug.print("{any}\n", .{chunk});
        start += 4;
        end += 4;
    }

    // std.debug.print("{any}\n", .{image});
    std.heap.c_allocator.free(image);
}

