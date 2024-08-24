const std = @import("std");
const mem = std.mem;
// const c = @cImport({
//     @cInclude("stdio.h");
// });


const strErr = error{notlen};

pub fn main() void {
    const str = "Hello";
    const str2 = "Hello3";

//    _ = c;

    std.debug.print("{!}\n", .{@TypeOf(str)});
    std.debug.print("{!}\n", .{@TypeOf(str2)});


    const strlen = str_len(str) catch 0;

    const strcp: []const u8 = str;

    const arr: [2][]const u8 = .{str, str2};

    std.debug.print("string 1: {s}\n", .{arr[0]});
    std.debug.print("string 2: {s}\n", .{arr[1]});
    std.debug.print("{!}\n", .{@TypeOf(arr)});
    std.debug.print("Len of string: {d}, strin: {s}\n", .{strlen, strcp});


}


fn str_len(str: [*]const u8) strErr!u32 {
    for(str, 0..1024) |c, i| {
        if (c == '\n' or c == 0) {
            return @intCast(i);
        }
    }
    return @intCast(0);
}
