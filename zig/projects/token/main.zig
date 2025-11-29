const std = @import("std");
const c = @cImport({
    @cInclude("openssl/ssl.h");
    @cInclude("openssl/err.h");
    @cInclude("ncurses.h");
});

const Tokens = struct { tokens: [][]u8 };

pub fn main() !void {
    const window = c.initscr() orelse return;
    _ = c.raw();
    _ = c.noecho();
    _ = c.keypad(window, true);

    var ch: c_int = 0;
    while (@as(u8, @intCast(ch)) != 'q') {
        _ = c.clear();
        _ = c.mvprintw(1, 2, "Hello %s", "world!");
        _ = c.refresh();
        ch = c.getch();
    }

    _ = c.endwin();
}
