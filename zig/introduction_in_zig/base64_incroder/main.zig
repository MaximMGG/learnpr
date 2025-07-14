const std = @import("std");
const Base64 = @import("base64.zig").Base64;

const stdout = std.io.getStdOut().writer();

fn _calc_encode_len(input: []const u8) !usize {
    if (input.len < 3) {
        return 4;
    }
    const n_output = try std.math.divCeil(usize, input.len, 3);
    return n_output * 4;
}

fn _calc_decode_len(input: []const u8) !usize {
    if (input.len < 4) {
        return 3;
    }
    const n_groups = try std.math.divCeil(usize, input.len, 4);
    var multiple_groups: usize = n_groups * 3;
    var i: usize = 0;
    while (i > 0) : (i -= 1) {
        if (input[i] == '=') {
            multiple_groups -= 1;
        } else {
            break;
        }
    }
    return multiple_groups;
}


pub fn main() !void {
    const base64 = Base64.init();
    try stdout.print("Character at index 28: {c}\n", .{base64._char_at(28)});
}
