const std = @import("std");
const c = @cImport(@cInclude("panel.h"));

const NLINES = 10;
const NCOLS = 40;



pub fn main() !void {
    var my_wins: [3]*c.WINDOW = undefined;
    var my_panels: [3]*c.PANEL = undefined;
    var top: *c.PANEL = undefined;
    var ch: c_int = 0;

    _ = c.initscr() orelse return error.InitscrError;
    _ = c.start_color();
    _ = c.cbreak();
    _ = c.noecho();
    _ = c.keypad(c.stdscr, true);

    _ = c.init_pair(1, c.COLOR_RED, c.COLOR_BLACK);
    _ = c.init_pair(2, c.COLOR_GREEN, c.COLOR_BLACK);
    _ = c.init_pair(3, c.COLOR_BLUE, c.COLOR_BLACK);
    _ = c.init_pair(4, c.COLOR_CYAN, c.COLOR_BLACK);

    try init_wins(&my_wins);

    my_panels[0] = c.new_panel(my_wins[0]) orelse return error.NewPanelError;
    my_panels[1] = c.new_panel(my_wins[1]) orelse return error.NewPanelError;
    my_panels[2] = c.new_panel(my_wins[2]) orelse return error.NewPanelError;

    _ = c.set_panel_userptr(my_panels[0], my_panels[1]);
    _ = c.set_panel_userptr(my_panels[1], my_panels[2]);
    _ = c.set_panel_userptr(my_panels[2], my_panels[0]);

    c.update_panels();

    _ = c.attron(c.COLOR_PAIR(4));
    _ = c.mvprintw(c.LINES - 2, 0, "Use tab to browse through the windows (F1 to Exit)");
    _ = c.attroff(c.COLOR_PAIR(4));
    _ = c.doupdate();

    top = my_panels[2];

    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        switch(ch) {
            9 => {
                top = @constCast(@ptrCast(c.panel_userptr(top).?));
                _ = c.top_panel(top);
            },
            else => {}
        }
        c.update_panels();
        _ = c.doupdate();
    }
    _ = c.endwin();
}

fn init_wins(wins: []*c.WINDOW) !void {
    var x: c_int = 2;
    var y: c_int = 10;
    var i: usize = 0;

    var lable: [80]u8 = .{0} ** 80;

    while(i < wins.len) : (i += 1){
        wins[i] = c.newwin(NLINES, NCOLS, y, x) orelse return error.NewwinError;
        const for_win_show = try std.fmt.bufPrint(&lable, "Window Number {d}", .{i + 1});
        win_show(wins[i], for_win_show, @intCast(i + 1));
        y += 3;
        x += 7;
        @memset(&lable, 0);
    }
}

fn win_show(win: *c.WINDOW, lable: []u8, lable_color: c_int) void {
    var startx: c_int = 0;
    var starty: c_int = 0;
    var height: c_int = 0;
    var width: c_int = 0;

    starty = c.getbegy(win);
    startx = c.getbegx(win);
    height = c.getmaxy(win);
    width = c.getmaxx(win);

    _ = c.box(win, 0, 0);

    _ = c.mvwaddch(win, 2, 0, 't');
    _ = c.mvwhline(win, 2, 1, 'q', width - 2);
    _ = c.mvwaddch(win, 2, width - 1, 'u');

    print_in_middle(win, 1, 0, width, lable, c.COLOR_PAIR(@intCast(lable_color)));

}

fn print_in_middle(win: ?*c.WINDOW, starty: c_int, startx: c_int, width: c_int, string: []u8, color: c_int) void {
    var length, var x, var y = @as([3]c_int, .{0} ** 3);
    var temp: f32 = 0;
    var temp_win: *c.WINDOW = undefined;
    var _width: c_int = 0;

    if (win == null) {
        temp_win = c.stdscr.?;
    } else {
        temp_win = win.?;
    }

    y = c.getcury(temp_win);
    x = c.getcurx(temp_win);

    if (startx != 0) {
        x = startx;
    }
    if (starty != 0) {
        y = starty;
    }
    if (width == 0) {
        _width = 80;
    }

    length = @intCast(string.len);
    temp = @floatFromInt(@divTrunc(width - length, 2));
    x = startx + @as(c_int, @intFromFloat(temp));
    _ = c.wattron(win, color);
    _ = c.mvwprintw(win, y, x, "%s", string.ptr);
    _ = c.wattroff(win, color);
    _ = c.refresh();
}

