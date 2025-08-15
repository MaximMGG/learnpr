const std = @import("std");
const Logger = std.filelog.Logger;
const c = @cImport({
    @cInclude("ncurses.h");
});


pub fn main() !void {
    var logger = try Logger.init("test.log");
    defer logger.deinit();
    _ = c.initscr();
    _ = c.noecho();
    _ = c.raw();
    _ = c.keypad(c.stdscr, true);
    _ = c.start_color();
    var y: c_int = 0;

    var ch: c_int = 0;

    try logger.log(.INFO, @src(), "Ncurses ready", .{});

    ch = c.getch();
    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        _ = c.clear();
        if (ch == 'j') {
            if (y < c.LINES - 1) {
                y += 1;
            }
        }
        if (ch == 'k') {
            if (y > 0) {
                y -= 1;
            }
        }

        _ = c.mvprintw(y, 0, "You press: %c", ch);
        try logger.log(.INFO, @src(), "Pressed key {c}", .{@as(u8, @intCast(ch))});
        _ = c.refresh();
    }

    _ = c.endwin();
}
