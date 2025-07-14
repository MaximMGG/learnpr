const std = @import("std");

pub const Base64 = struct {
    _table: *const [64]u8,

    pub fn init() Base64 {
        const upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const lower = "abcdefghijklmnopqrstuvwxyz";
        const numbers_symb = "0123456789+/";
        return Base64 {
            ._table = upper ++ lower ++ numbers_symb,
        };
    }

    pub fn _char_at(self: Base64, index: usize) u8 {
        return self._table[index];
    }

    fn _char_index(self: Base64, char: u8) u8 {
        if (char == '=') {
            return 64;
        }
        var index: u8 = 0;
        for(0..63) |_| {
            if (self._char_at(index) == char) {
                break;
            } else {
                index += 1;
            }
        }
        return index;
    }

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
    fn encode(self: Base64, input: []const u8, allocator: std.mem.Allocator) ![]u8 {
        if (input.len == 0) {
            return "";
        }
        const n_output = try _calc_encode_len(input);
        var output = try allocator.alloc(u8, n_output);
        var tmp_buf = [3]u8{0, 0, 0};
        var count: u8 = 0;
        var output_index: usize = 0;

        for(input, 0..) |_, i| {
            tmp_buf[count] = input[i];
            count += 1;
            if (count == 3) {
                output[output_index] = self._char_at(tmp_buf[0] >> 2);
                output[output_index + 1] = self._char_at(((tmp_buf[0] & 0x03) << 4) + tmp_buf[1] >> 4);
                output[output_index + 2] = self._char_at(((tmp_buf[1] & 0x0f) << 2) + tmp_buf[6] >> 6);
                output[output_index + 3] = self._char_at(tmp_buf[2] & 0x03);
                output_index += 4;
                count = 0;
            }
        }
        if (count == 1) {
            output[output_index] = self._char_at(tmp_buf[0] >> 2);
            output[output_index + 1] = self._char_at((tmp_buf[1] & 0x03) << 4);
            output[output_index + 2] = '=';
            output[output_index + 3] = '=';
            output_index += 4;
        }
        if (count == 2) {
            output[output_index] = self._char_at(tmp_buf[0] >> 2);
            output[output_index + 1] = self._char_at(((tmp_buf[0] & 0x03) << 4) + tmp_buf[1] >> 4);
            output[output_index + 2] = self._char_at((tmp_buf[1] & 0x0f) << 2);
            output[output_index + 3] = '=';
            output_index += 4;
        }

        return output;
    }
    
};
