const std = @import("std");

pub fn main() !void {
    var str: []u8 = @ptrCast(@constCast("Hello"));
    std.debug.print("{any}\n", .{@TypeOf(str)});

    std.debug.print("{s}\n", .{str});
    std.debug.print("{s}\n", .{str[0..str.len]});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var astr = try allocator.alloc(u8, 128);
    defer allocator.free(astr);
    @memset(astr[0..128], 0);
    astr[0] = 'Q';

    std.debug.print("{s}\n", .{astr});

    var sstr: [128]u8 = .{0} ** 128;
    @memcpy(sstr[0.."w".len], "w"[0.."w".len]);
    std.mem.copyForwards(u8, sstr[0..sstr.len], "Wow");

    sstr[2] = 'W';
    std.debug.print("{s}\n", .{sstr});
}
