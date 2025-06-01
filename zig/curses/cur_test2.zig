const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
    @cInclude("curses.h");
    @cInclude("string.h");
});

pub fn main() !void {
    var y: c_int = 0;
    var x: c_int = 0;
    var str: [80]u8 = .{0} ** 80;
    const msg = "Enter a string: ";

    const stdscr = c.initscr() orelse return error.InitscrError;
    y = c.getmaxy(stdscr);
    x = c.getmaxx(stdscr);
    _ = c.mvprintw(@divTrunc(y, @as(c_int, 2)), @divTrunc(x, @as(c_int, 2)), "%s", msg);
    
    _ = c.getstr((&str).ptr);
    _ = c.mvprintw(c.LINES - 2, 0, "You etered: %s", (&str).ptr);


    _ = c.getch();
    _ = c.endwin();

}
