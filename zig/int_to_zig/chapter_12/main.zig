const std = @import("std");
const expect = std.testing.expect;

pub fn main() !void {

}

fn comptime_slice(comptime T: type, comptime len: usize) []T {
    var arr: [len]T = undefined;
    return arr[0..len];

}

fn twice(comptime n: i32) i32 {
    return n * 2;
}

test "twice test" {
    try expect(twice(4) == 8);
}

test "slice test" {
    const arr = comptime blk: {
        break :blk comptime_slice(u32, 100);
    };
    arr[0] = 123;
    try expect(arr[0] == 123);
    try expect(arr.len == 100);
}
