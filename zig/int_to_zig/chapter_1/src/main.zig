const std = @import("std");
const testing = std.testing.expect;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"world"});

    var a = @as(i32, 39);
    a += 1;

    try stdout.print("{any}\n", .{@TypeOf(stdout)});

    try stdout.print("{d}\n", .{a});

    //const age = 178;

    // _ = age;
    // try stdout.print("Age: {d}\n", .{age});
    try arrays(stdout);
}

fn arrays(w: anytype) !void {
    const f: f32 = 3.8;

    try w.print("{any}\n", .{@TypeOf(w)});

    const i: i32 = @bitCast(f);

    try w.print("Int: {d}\n", .{i});

    const f2: f32 = @bitCast(i);

    try w.print("Float after cast: {d}\n", .{f2});

    const ns = [4]u8{ 48, 24, 12, 6 };
    const ls = [_]f32{ 12.4, 32.1, 1.2, 99.8 };
    _ = ns;
    _ = ls;
    const nss: [4]u8 = .{ 2, 8, 6, 1 };
    try w.print("{any}\n", .{@TypeOf(nss)});
    try w.print("{any}\n", .{nss});

    try testing(@TypeOf(nss) == [4]u8);

    try w.print("Slicing\n", .{});

    const slice_nss = nss[1..3];

    try w.print("{any}\n", .{slice_nss});
    try w.print("Type of slice -> {any}\n", .{@TypeOf(slice_nss)});
    try w.print("{d}\n", .{slice_nss[0]});

    var vs = [4]u8{ 9, 8, 7, 6 };
    vs[3] = 10;

    try testing(@TypeOf(vs) == [4]u8);
    try w.print("{any}\n", .{vs});
    try w.print("Type of vs: {any}\n", .{@TypeOf(vs)});

    const slice_vs = vs[1..3];

    try w.print("{any}\n", .{slice_vs});
    try w.print("Type of slice_vs -> {any}\n", .{@TypeOf(slice_vs)});
    try w.print("{d}\n", .{slice_vs[0]});
}
