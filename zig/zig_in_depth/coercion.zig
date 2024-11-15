const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const a: u8 = 42;
    const b: u16 = a;
    const c: u32 = b;
    const d: u64 = c;
    const e: u128 = d;
    print("int widening: u8 ... -> u128: {} {}\n\n", .{ e, @TypeOf(e) });

    const f: f16 = 3.1415;
    const g: f32 = f;
    const h: f64 = g;
    const i: f80 = h;
    const j: f128 = i;
    print("float widening: f16 ... -> f128: {} {}\n\n", .{ j, @TypeOf(j) });

    const a_u8: u8 = 42;
    const a_result = add(a_u8, a_u8);
    print("function args: u8 -> u16 -> u32: {} {}\n\n", .{ a_result, @TypeOf(a_result) });

    const b_u64: u64 = 2000;
    const b_result = add(a_u8, b_u64);
    print("comptime narrowing u64 -> u32? {} {}\n\n", .{ b_result, @TypeOf(b_result) });

    const array = [_]u8{ 1, 2, 3 };
    const b_slice: []const u8 = &array;
    const c_mptr: [*]const u8 = &array;
    _ = c_mptr;

    var a_optional: ?u8 = null;
    a_optional = a_u8;
    var a_err: anyerror!u8 = error.InvalidNumber;
    a_err = a_u8;

    var runtime_zero: usize = 0;
    var happy_medium = if (runtime_zero > 12) a else f;
    _ = &runtime_zero;
    _ = &happy_medium;
    print("peer if: u8 or f16 -> f16: {} {}\n\n", .{ happy_medium, @TypeOf(happy_medium) });

    const c_result = a + e;
    print("peer add: u8 + u128 -> u128: {} {}\n\n", .{ c_result, @TypeOf(c_result) });

    const k: u8 = @intFromFloat(f);
    print("@intFromFloat: f16 -> u8: {} {}\n\n", .{ k, @TypeOf(k) });

    const l: f16 = @floatFromInt(c);
    print("@floatFromInt: u32 -> f16: {} {}\n\n", .{ l, @TypeOf(l) });

    const d_ptr: [*]const u8 = @ptrCast(b_slice);
    print("@ptrCast: []const u8 -> [*]const u8: {}\n\n", .{@TypeOf(d_ptr)});

    const float: f64 = 3.141592;
    const bits: u64 = @bitCast(float);
    const as_u64: u64 = @intFromFloat(float);
    const as_f64: f64 = @bitCast(bits);
    print("@bitCast:\n", .{});
    print("f64: {d}\n", .{float});
    print("u64 bits: {b}\n", .{bits});
    print("u64 re_interpret: {d}\n", .{as_u64});
    print("u64 re_interpret bits: {b}\n", .{as_u64});
    print("back to f64: {d}\n\n", .{as_f64});

    const big_int: u64 = 20_000_000_000;
    const little_int: u32 = @truncate(big_int);
    print("@intCast narrowing: u64 -> u32: {}\n\n", .{little_int});
}

fn add(a: u8, b: u16) u32 {
    return a + b;
}
