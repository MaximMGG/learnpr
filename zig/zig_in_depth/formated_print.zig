const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    print("All your {s} are belong to us.\n\n", .{"codebase"});

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run 'zig build test' to run the tests\n", .{});

    const float: f64 = 3.1415;
    try stdout.print("float: '{}' '{0d}', '{0d:0<10.2}' '{0d:0^10.2}' '{0d:0>10.2}' \n\n", .{float});

    const int: u8 = 42;
    try stdout.print("int decimal: {}\n", .{int});
    try stdout.print("int binary: {b}\n", .{int});
    try stdout.print("int octal: {o}\n", .{int});
    try stdout.print("int hex: {x}\n", .{int});
    try stdout.print("int ASCII: {c}\n", .{int});
    try stdout.print("int Unicode: {u}\n", .{int});

    try bw.flush();

    const string = "Hello, world!";
    try stdout.print("string: {s}, '{0s:_^20}' \n\n", .{string});

    const optional: ?u8 = 42;
    try stdout.print("optional: '{?}' '{?}' \n", .{ optional, @as(?u8, null) });
    try stdout.print("optional: '{?d:0>10}' \n\n", .{optional});

    const error_union: anyerror!u8 = error.WrongNumber;

    try stdout.print("error union: '{!}' '{!}'\n", .{ error_union, @as(anyerror!u8, 13) });
    try stdout.print("error union: '{!d:0>10}' \n\n", .{@as(anyerror!u8, 13)});
    try bw.flush();

    const ptr = &float;
    try stdout.print("pointer: '{}' '{0*}' '{}'\n", .{ ptr, ptr.* });

    const S = struct {
        a: bool = true,
        b: f16 = 3.1415,
    };

    const s = S{};
    try stdout.print("'s: {[a]}' '{[b]d:0>10.2}'\n\n", s);

    try stdout.print("'s: {}' '{d:0>10.2}' \n\n", .{ s.a, s.b });

    var buf: [256]u8 = undefined;
    const str = try std.fmt.bufPrint(&buf, "'{[a]}' '{[b]d:0>10.2}' \n\n", s);
    try stdout.print("std: {s}\n", .{str});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const str_alloc = try std.fmt.allocPrint(alloc, "'{[a]}' '{[b]d:0>10.2}'", s);
    defer alloc.free(str_alloc);
    try stdout.print("str_alloc: {s}\n", .{str_alloc});
    try stdout.print("curly: {{s}} \n\n", .{});
    try bw.flush();

    print("debuf.print: {} \n\n", .{float});
    std.log.debug("{} ", .{float});
    std.log.info("{} ", .{float});
    std.log.warn("{} ", .{float});
    std.log.err("{}\n", .{float});

    print("any: '{any}' '{any}' '{any}'\n", .{ s, string, float });
}
