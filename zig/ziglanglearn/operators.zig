const print = @import("std").debug.print;

pub fn main() void {
    //print("operator + -> {d}\n", .{@as(u32, 0xffffffff) + 1}); overflow
    print("operator +% -> {d}\n", .{@as(u32, 0xffffffff) +% 1});
    print("operator +| -> {d}\n", .{@as(u8, 255) +| @as(u8, 255)});
    print("operator -% -> {d}\n", .{@as(u32, 0) -% 1});
    print("operator -| -> {d}\n", .{@as(u8, 0) -| 1});
    print("operator *% -> {d}\n", .{@as(u8, 200) *% 2});
    print("operator *| -> {d}\n", .{@as(u8, 200) *| 2});
}
