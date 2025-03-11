const std = @import("std");
const base64 = @import("Base64.zig");

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const b64 = base64.Base64.init();
    try stdout.print("{c}\n", .{b64._char_at(3)});
}

fn _calc_encode_length(input: []const u8) !usize {
    if (input.len < 3) {
        return @as(usize, 4);
    }

    const output: usize = try std.math.divCeil(usize, input.len, 3);
    return output * 3;
}
