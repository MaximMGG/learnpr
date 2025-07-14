const std = @import("std");
const c = @cImport(@cInclude("ncurses.h"));


pub fn main() !void {
    _ = c.initscr() orelse return error.InitScrError;
    _ = c.raw();
    _ = c.keypad(c.stdscr, true);
    _ = c.refresh();

    var ch: c_int = 0;
    var buf: [128]u8 = .{0} ** 128;
    var i: usize = 0;

    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        buf[i] = @as(u8, @intCast(ch));
        i += 1;
    }

    _ = c.mvprintw(4, 0, (&buf).ptr);

    _ = c.getch();
    _ = c.endwin();
}
