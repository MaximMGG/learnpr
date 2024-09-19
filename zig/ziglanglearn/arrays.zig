const std = @import("std");
const expect = std.testing.expect;
const assert = std.debug.assert;
const mem = std.mem;

const message = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
const alt_message: [5]u8 = .{ 'h', 'e', 'l', 'l', 'o' };

comptime {
    assert(mem.eql(u8, &message, &alt_message));
}

comptime {
    assert(message.len == 5);
}

const same_message = "hello";

comptime {
    assert(mem.eql(u8, &message, same_message));
}

test "iterate over an array" {
    var sum: usize = 0;
    for (message) |byte| {
        sum += byte;
    }
    try expect(sum == 'h' + 'e' + 'l' * 2 + 'o');
}
var some_integers: [100]i32 = undefined;

test "modife an array" {
    for (&some_integers, 0..) |*item, i| {
        item.* = @intCast(i);
    }
    try expect(some_integers[10] == 10);
    try expect(some_integers[99] == 99);
}

const hello = "hello";
const world = "world";
const hello_world = hello ++ " " ++ world;

comptime {
    assert(mem.eql(u8, hello_world, "hello world"));
}

const all_zero = [_]u16{0} ** 10;

comptime {
    assert(all_zero.len == 10);
    assert(all_zero[5] == 0);
}

var fancy_array = init: {
    var initial_value: [10]Point = undefined;
    for (&initial_value, 0..) |*pt, i| {
        pt.* = Point{ .x = @intCast(i), .y = @intCast(i * 2) };
    }
    break :init initial_value;
};

const Point = struct { x: i32, y: i32 };

test "compile-time array initialization" {
    try expect(fancy_array[4].x == 4);
    try expect(fancy_array[4].y == 8);
}

var more_points = [_]Point{makePoint(3)} ** 10;
fn makePoint(x: i32) Point {
    return Point{ .x = x, .y = x * 2 };
}

test "array initialization with function calls" {
    try expect(more_points[4].x == 3);
    try expect(more_points[4].y == 6);
    try expect(more_points.len == 10);
}
