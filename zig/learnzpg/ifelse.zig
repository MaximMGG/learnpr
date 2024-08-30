const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    print("{d}\n", .{sey_period(0)});
    print("{d}\n", .{sey_period(1)});
    print("{d}\n", .{sey_period(4)});
    print("{d}\n", .{sey_period(17)});
    print("{d}\n", .{sey_period(107)});

    const arr1 = [_]u32{ 1, 2, 3, 4, 5 };
    print("{any}\n", .{in_array(arr1[0..], 3)});
    print("{any}\n", .{in_array(arr1[0..], 13)});
    print("type of arr is: {any}\n", .{@TypeOf(arr1)});
    print("type of arr is: {any}\n", .{@TypeOf(arr1[0..])});

    const str1 = "Bobby";
    const str2 = "Bobby";
    const str3 = "Bobcy";
    const str4 = "Bob";

    print("String1 {s} and String2 {s} is the same? {any}\n", .{ str1, str2, eql(u8, str1, str2) });
    print("String1 {s} and String2 {s} is the same? {any}\n", .{ str1, str3, eql(u8, str1, str3) });
    print("String1 {s} and String2 {s} is the same? {any}\n", .{ str1, str4, eql(u8, str1, str3) });

    const arrIndex: []const u32 = &[_]u32{ 1, 2, 3, 4, 5 };
    const a: ?usize = indexOf(arrIndex, 7);
    print("Index of {d} is: {any}\n", .{ 3, a orelse 0 });

    // print("Returning name is {s}\n", .{returnName(1)});
    // print("Returning name is {s}\n", .{returnName(2)});
    // print("Returning name is {s}\n", .{returnName(3)});
    print("Storage is: {s}\n", .{if (Storage.isComplite(.any)) @tagName(.any) else "none"});
}

fn sey_period(i: i32) i32 {
    switch (i) {
        0 => return 100,
        1 => return 200,
        3...5 => return 300,
        6...19 => return 500,
        else => {
            return i * 5;
        },
    }
}

fn in_array(arr: []const u32, num: u32) bool {
    for (arr) |i| {
        if (i == num) {
            return true;
        }
    }
    return false;
}

fn eql(comptime T: type, a: []const T, b: []const T) bool {
    if (a.len != b.len) {
        return false;
    }

    for (a, b) |ai, bi| {
        if (ai != bi) return false;
    }
    return true;
}

fn indexOf(arr: []const u32, num: u32) ?usize {
    for (arr, 0..) |n, i| {
        if (n == num) {
            return i;
        }
    }
    return null;
}

fn returnName(num: u32) []const u8 {
    const name = b: {
        if (num == 1) break :b "Hello";
        if (num == 2) break :b "Hello2";
        if (num > 2) break :b "Bye";
    } orelse "a";
    return name.*;
}

const Storage = enum {
    any,
    comfirmed,
    anything,
    end,

    fn isComplite(self: Storage) bool {
        return self == .any or self == .end;
    }
};
