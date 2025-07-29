const std = @import("std");

const NB_COLS = 161;
const NB_ROWS = 38;
//              Y        X
var screen: [NB_ROWS][NB_COLS]u8 = .{.{' '} ** NB_COLS} ** NB_ROWS;
var buffer: [3 + NB_ROWS * (NB_COLS + 1)]u8 = undefined;


fn desplay_screen(stdout: std.io.AnyWriter) void {

}



pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    // Clear screen & hides cursor
    try stdout.writeAll("\x1B[2J\x1B[H\x1B[?25h");

    // put cursor at position (0, 0)
    buffer[0] = '\x1B';
    buffer[1] = '[';
    buffer[2] = 'H';
    while(true) {
        try stdout.print("\x1B[H{s}", .{buffer});
    }
}
