const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
    @cInclude("curses.h");
});


var MAX_X: c_int = 0;
var MAX_Y: c_int = 0;
const stdout = std.io.getStdOut().writer();


pub fn main() !void {
    var ch: c_int = 0;

    var y: c_int = 0;
    var x: c_int = 0;

    const stdscr = c.initscr() orelse return error.InitSrcError;
    _ = c.raw();
    _ = c.noecho();
    _ = c.keypad(stdscr, true);

    MAX_X = c.getmaxx(stdscr);
    MAX_Y = c.getmaxy(stdscr);



    while(true) {
        ch = c.getch();
        if (ch == c.KEY_F(1)) {
            break;
        }
        if (ch == c.KEY_LEFT) {
            x = if (x == 0) 0 else x - 1;
        } else if (ch == c.KEY_RIGHT) {
            x = if (x == MAX_X) MAX_X else x + 1;
        } else if (ch == c.KEY_UP) {
            y = if (y == 0) 0 else y - 1;
        } else if (ch == c.KEY_DOWN) {
            y = if (y == MAX_Y) MAX_Y else y + 1;
        } else {

        }

        _ = c.clear();
        _ = c.mvprintw(y, x, "%c", @as(c_char, 'a'));
        _ = c.refresh();
        try stdout.print("y: {d}, x: {d}\n", .{y, x});
    }

    _ = c.endwin();
}
