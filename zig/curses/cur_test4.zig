const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");

});

pub fn main() !void {
    _ = c.initscr() orelse return error.InitScrError;
    _ = c.start_color();

    _ = c.init_pair(@as(c_short, 1), c.COLOR_CYAN, c.COLOR_BLACK);
    _ = c.printw("A Big string which i did't care type fully ");
    _ = c.mvchgat(@as(c_int, 0), @as(c_int, 0), @as(c_int, -1), c.A_BLINK, @as(c_short, 1), null);

    _ = c.refresh();
    _ = c.getch();
    _ = c.endwin();
}
