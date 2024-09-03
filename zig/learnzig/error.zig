const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const a: MyError!i32 = action(2, 40) catch |err| switch (err) {
        MyError.smoolInt => 1,
        MyError.bigInt => 2,
        MyError.noInt => 3,
    };
    print("a == {!d}\n", .{a});
    const b: MyError!i32 = action(502, 9);
    print("b is: {!d}\n", .{b});

    const nn: ?[]const u8 = "Bobby";
    print("nn is {?s}\n", .{nn});
}

fn action(a: i32, b: i32) MyError!i32 {
    if (a < 50) {
        return MyError.smoolInt;
    } else if (a > 500) {
        return MyError.bigInt;
    } else if (a == 0) {
        return MyError.noInt;
    } else {
        return a + b;
    }
}

const MyError = error{ smoolInt, bigInt, noInt };
