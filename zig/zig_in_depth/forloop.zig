const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const array = [_]u8{ 0, 1, 2, 3, 4, 5 };
    var array2: [6]u8 = undefined;
    const a = array[0 .. array.len - 1];
    print("a -> {}\n", .{@TypeOf(a)});
    print("a.ptr -> {}\n", .{@TypeOf(a.ptr)});
    print("{}\n", .{a.ptr[0]});

    for (array) |u| print("{} ", .{u});
    print("\n", .{});

    for (array[0..4]) |u| print("{} ", .{u});
    print("\n", .{});

    for (array, 0..) |u, i| print("{} -> {}\n", .{ i, u });

    for (array[0..2], array[1..3], array[2..4]) |ia, ib, ic| print("{}-{}-{}\n", .{ ia, ib, ic });

    for (3..10) |i| print("{} ", .{i});
    print("\n", .{});

    comptime var sum: usize = 0;
    comptime for (array) |item| {
        if (item == 3) continue;
        if (item == 4) break;
        sum += item;
    };
    print("Sum is: {}\n", .{sum});

    sum = 0;
    comptime outer: for (0..10) |i| {
        in: for (1..4) |li| {
            if (i == 5) break :outer;
            if (li == 3) break :in;
            sum += li;
        }
    };
    std.mem.copyForwards(u8, &array2, &array);
    print("Sum is: {}\n", .{sum});

    for (&array2) |*item| {
        item.* += 2;
    }
    print("Array {any}\n", .{array2});

    const maybe_nums = [_]?u8{ 1, 2, 3, null, null };

    const just_nums = for (maybe_nums, 0..) |num, i| {
        if (num == null) break maybe_nums[0..i];
    } else maybe_nums[0..];
    print("{any}\n", .{just_nums});
}
