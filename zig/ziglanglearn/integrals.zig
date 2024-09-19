const std = @import("std");

const decimal_int = 98222;
const hex_int = 0xff;
const another_hex_int = 0xFF;
const octal_int = 0o755;
const binary_int = 0b11110000;

// underscores may be placed between two digits as a visual separator
const one_billion = 1_000_000_000;
const binary_mask = 0b1_1111_1111;
const permissions = 0o7_5_5;
const big_address = 0xFF80_0000_0000_0000;

pub fn main() void {
    std.debug.print("Number decimal_int {d}\n", .{decimal_int});
    std.debug.print("Number hex_int 0x{x}\n", .{hex_int});
    std.debug.print("Number another_hex_int {X}\n", .{0xFF});
    std.debug.print("Number octal_int {o}\n", .{octal_int});
    std.debug.print("Number binary_int {b}\n", .{binary_int});
    std.debug.print("Number one_billion {d}\n", .{one_billion});
    std.debug.print("Number binary_mask {b}\n", .{binary_mask});
    std.debug.print("Number permissions {o}\n", .{permissions});
    std.debug.print("Number big_address 0x{X}\n", .{big_address});
}
