const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const tuple_a: struct { u8, bool } = .{ 42, true };
    print("tuple_a: {any}, {}\n", .{ tuple_a, @TypeOf(tuple_a) });

    print("tuple_a[0]: {}\n", .{tuple_a[0]});
    print("tuple_a.len: {}\n", .{tuple_a.len});

    print("tuple_a.@\"0\": {}\n", .{tuple_a.@"0"});

    const @"123" = 123;
    _ = @"123";
    const @"while" = "a keyword!";
    _ = @"while";

    const tuple_b: struct { f16, i32 } = .{ 3.13, -42 };
    const tuple_c = tuple_a ++ tuple_b;
    print("tuple_c; {any}\n", .{tuple_c});
    const array: [3]u8 = .{ 1, 2, 3 };
    const tuple_d = .{ 4, 5, 6 };
    const result = array ++ tuple_d;
    print("result: {any}, {}\n", .{ result, @TypeOf(result) });

    inline for (tuple_c, 0..) |value, i| {
        print("{}: {}\n", .{ i, value });
    }
    print("\n", .{});

    const ptr = &tuple_c;
    print("ptr[0]: {}\n", .{ptr[0]});
    print("ptr.@\"0\": {}\n", .{ptr.@"0"});

    varargsInZig(.{ 42, 3.14, false });
}

fn varargsInZig(x: anytype) void {
    const info = @typeInfo(@TypeOf(x));
    if (info != .Struct) @panic("Not a tuple!");
    if (!info.Struct.is_tuple) @panic("Not a tuple!");

    inline for (x) |field| print("{}\n", .{field});
}
