const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
});


pub fn main() !void {
    _ = c.initscr() orelse return error.InitScrError;
    if (c.has_colors() == false) {
        _ = c.endwin();
        std.debug.print("Your terminal doesn't support colors\n", .{});
        return;
    }
    _ = c.start_color();
    _ = c.init_pair(1, c.COLOR_RED, c.COLOR_BLACK);

    _ = c.attron(c.COLOR_PAIR(1));
    print_in_middle(c.stdscr, @divTrunc(c.LINES, 2), 0, c.COLS, "Viola !!! In Color ...");
    _ = c.attroff(c.COLOR_PAIR(1));
    _ = c.getch();
    _ = c.endwin();

}

fn print_in_middle(_win: ?*c.WINDOW, starty: c_int, startx: c_int, _width: c_int, string: []const u8) void {
    var length, var x, var y = @as([3]c_int, .{0} ** 3);
    var temp: f32 = 0;
    var win: *c.WINDOW = undefined;
    var width: c_int = 0;

    if (_win == null) {
        win = c.stdscr;
    } else {
        win = _win.?;
    }
    x = c.getcurx(win);
    y = c.getcury(win);
    if (startx != 0) {
        x = startx;
    }
    if (starty != 0) {
        y = starty;
    }
    if (_width == 0) {
        width = 80;
    } else {
        width = _width;
    }

    length = @intCast(string.len);
    temp = @floatFromInt(@divTrunc(width - length, 2));
    x = startx + @as(c_int, @intFromFloat(temp));
    _ = c.mvwprintw(win, y, x, "%s", string.ptr);
    _ = c.refresh();
}
