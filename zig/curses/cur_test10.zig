const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
    @cInclude("stdlib.h");
});


pub fn main() !void {
    _ = c.initscr() orelse return error.InitscrError;
    _ = c.printw("Hello world!!!\n");
    _ = c.refresh();
    _ = c.def_prog_mode();
    _ = c.endwin();
    _ = c.system("/bin/sh");
    _ = c.reset_prog_mode();
    _ = c.refresh();

    _ = c.printw("Another string\n");
    _ = c.refresh();
    _ = c.endwin();

}
