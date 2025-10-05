const std = @import("std");



pub extern "c" fn load_png(len: *c_uint) [*c]u8;


pub fn main() !void {

    var len: c_uint = 0;
    var image: []u8 = undefined;
    image.ptr = @ptrCast(load_png(&len));
    image.len = @intCast(len);

    std.debug.print("{any}\n", .{image});
}
