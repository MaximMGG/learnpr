const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const a = [5]i32{ 1, 2, 3, 4, 5 };
    // const b: [5]i32 = .{ 1, 2, 3, 4, 5 };
    // const c = [_]i32{ 1, 2, 3, 4, 5 };
    // const b = a[0..3];
    // _ = b;
    const end: usize = 4;
    const c = a[1..end];

    print("{any}\n", .{@TypeOf(a)});

    print("{any}\n", .{@TypeOf(a[0..])});
    print("{any}\n", .{@TypeOf(c)});
    print_arr(a);
    // print_arr(b);
    // print_arr(c);
}

pub fn print_arr(arr: []const i32) void {
    for (arr) |a| {
        print("{d}\n", a);
    }
}
