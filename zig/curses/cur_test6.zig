const std = @import("std");
const builtin = @import("builtin");
const c = @cImport({
    @cInclude("ncurses.h");
});

const WIN_BORDER = struct {
    ls: c.chtype,
    rs: c.chtype,
    ts: c.chtype,
    bs: c.chtype,
    tl: c.chtype,
    tr: c.chtype,
    bl: c.chtype,
    br: c.chtype,
};

const WIN = struct {
    startx: c_int,
    starty: c_int,
    height: c_int,
    width: c_int,
    border: WIN_BORDER
};


pub fn main() !void {
    var win: WIN = undefined;
    var ch: c_int = 0;
    _ = c.initscr() orelse return error.initsrcError;
    _ = c.start_color();
    _ = c.cbreak();

    _ = c.keypad(c.stdscr,  true);
    _ = c.noecho();
    _ = c.init_pair(1, c.COLOR_CYAN, c.COLOR_BLACK);

    init_win_params(&win);
    print_win_params(&win);

    _ = c.attron(c.COLOR_PAIR(1));
    _ = c.printw("Press F1 to exit");
    _ = c.refresh();
    _ = c.attroff(c.COLOR_PAIR(1));

    create_box(&win, true);
    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        switch(ch) {
            c.KEY_LEFT => {
                create_box(&win, false);
                win.startx -= 1;
                create_box(&win, true);
            },
            c.KEY_RIGHT => {
                create_box(&win, false);
                win.startx += 1;
                create_box(&win, true);
            },
            c.KEY_UP => {
                create_box(&win, false);
                win.starty -= 1;
                create_box(&win, true);
            },
            c.KEY_DOWN => {
                create_box(&win, false);
                win.starty += 1;
                create_box(&win, true);
            },
            else => {}
        }
    }
    _ = c.endwin();
}


fn init_win_params(p_win: *WIN) void {
    p_win.height = 3;
    p_win.width = 10;
    p_win.starty = @divTrunc((c.LINES - p_win.height), 2);
    p_win.startx = @divTrunc((c.COLS - p_win.width), 2);

    p_win.border.ls = @intCast('|');
    p_win.border.rs = @intCast('|');
    p_win.border.ts = @intCast('-');
    p_win.border.bs = @intCast('-');
    p_win.border.tl = @intCast('+');
    p_win.border.tr = @intCast('+');
    p_win.border.bl = @intCast('+');
    p_win.border.br = @intCast('+');
}

fn print_win_params(p_win: *WIN) void {
    if (builtin.mode == .Debug) {
        _ = c.mvprintw(25, 0, "%d %d %d %d", p_win.startx, p_win.starty, p_win.width, p_win.height);
        _ = c.refresh();
    }
}

fn create_box(p_win: *WIN, flag: bool) void {
    var i, var j, var x, var y, var w, var h = @as([6]c_int, .{0} ** 6);

    x = p_win.startx;
    y = p_win.starty;
    w = p_win.width;
    h = p_win.height;

    if (flag == true) {
        _ = c.mvaddch(y, x, p_win.border.tl);
        _ = c.mvaddch(y, x + w, p_win.border.tr);
        _ = c.mvaddch(y + h, x, p_win.border.bl);
        _ = c.mvaddch(y + h, x + w, p_win.border.br);
        _ = c.mvhline(y, x + 1, p_win.border.ts, w - 1);
        _ = c.mvhline(y + h, x + 1, p_win.border.bs, w - 1);
        _ = c.mvaddch(y + 1, x, p_win.border.ls);
        _ = c.mvaddch(y + 2, x, p_win.border.ls);
        _ = c.mvaddch(y + 1, x + w, p_win.border.ls);
        _ = c.mvaddch(y + 2, x + w, p_win.border.ls);
    } else {
        j = y;
        i = x;
        _ = c.mvprintw(0, 0, "x: %d", x);
        _ = c.mvprintw(1, 0, "y: %d", y);
        _ = c.mvprintw(2, 0, "w: %d", w);
        _ = c.mvprintw(3, 0, "h: %d", h);
        _ = c.mvprintw(4, 0, "j: %d, i: %d", j, i);
        while(j <= y + h) : (j += 1) {
            i = x;
            while(i <= x + w) : (i += 1) {
                _ = c.mvaddch(j, i,  @as(u8, ' '));
            }
        }
    }
    _ = c.refresh();
}

