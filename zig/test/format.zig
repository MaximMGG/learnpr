const std = @import("std");


fn parse_cmd(comptime fmt: []const u8, args: anytype) !void {
    const t = @typeInfo(@TypeOf(args));
    if (t != .@"struct") {
        @compileError("args not a struct");
    }
    const f_info = t.@"struct".fields;

    const a1 = @as(*i32, @field(args, f_info[0].name));
    const a2 = @as(*i32, @field(args, f_info[1].name));
    const a3 = @as(*u8, @field(args, f_info[2].name));

    var start_i: usize = 0;
    var end_i: usize = 0;
    end_i = std.mem.indexOfScalar(u8, fmt, ',') orelse return;
    a1.* = try std.fmt.parseInt(i32, fmt[start_i..end_i], 10);
    start_i += end_i + 1;
    end_i = start_i;
    end_i += std.mem.indexOfNone(u8, fmt, "0123456789") orelse return;
    end_i += 1;
    a2.* = try std.fmt.parseInt(i32, fmt[start_i..end_i], 10);
    start_i += end_i + 1;
    a3.* = fmt[end_i..][0];
}

pub fn main() !void {

    var a1: i32 = 0;
    var a2: i32 = 0;
    var cmd: u8 = 0;
    const fmt = "23,412i";

    try parse_cmd(fmt, .{&a1, &a2, &cmd});

    std.debug.print("{d} {d} {c}\n", .{a1, a2, cmd});

}
