const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
});

pub fn main() !void {
    var my_win: *c.WINDOW = undefined;
    var startx: c_int = 0;
    var starty: c_int = 0;
    var width: c_int = 0;
    var height: c_int = 0;
    var ch: c_int = 0;
    const stdscr = c.initscr() orelse return error.InitScrError;
    _ = c.cbreak();
    _ = c.keypad(stdscr, true);

    height = 3;
    width = 10;
    starty = @divTrunc((c.LINES - height), @as(c_int, 2));
    startx = @divTrunc((c.COLS - width), @as(c_int, 2));
    _ = c.printw("Press F1 to exit");
    _ = c.refresh();
    
    my_win = create_newwin(height, width, starty, startx);

    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        switch(ch) {
            c.KEY_LEFT => {
                destroy_window(my_win);
                my_win = create_newwin(height, width, starty, startx - @as(c_int, 1));
                startx -= @as(c_int, 1);
            },
            c.KEY_RIGHT => {
                destroy_window(my_win);
                my_win = create_newwin(height, width, starty, startx + @as(c_int, 1));
                startx += @as(c_int, 1);
            },
            c.KEY_UP => {
                destroy_window(my_win);
                my_win = create_newwin(height, width, starty - @as(c_int, 1), startx);
                starty -= @as(c_int, 1);
            },
            c.KEY_DOWN => {
                destroy_window(my_win);
                my_win = create_newwin(height, width, starty + @as(c_int, 1), startx);
                starty += @as(c_int, 1);
            },
            else => continue
        }
    }
    _ = c.endwin();
}

fn create_newwin(height: c_int, width: c_int, starty: c_int, startx: c_int) *c.WINDOW {
    var local_win: *c.WINDOW = undefined;
    local_win = c.newwin(height, width, starty, startx);
    _ = c.box(local_win, @as(c.chtype, 0), @as(c.chtype, 0));

    _ = c.wrefresh(local_win);
    return local_win;
}

fn destroy_window(local_win: *c.WINDOW) void {
    _ = c.wborder(local_win, 
        @as(c.chtype, ' '), 
        @as(c.chtype, ' '), 
        @as(c.chtype, ' '), 
        @as(c.chtype, ' '), 
        @as(c.chtype, ' '),
        @as(c.chtype, ' '), 
        @as(c.chtype, ' '), 
        @as(c.chtype, ' '),
        );
    _ = c.wrefresh(local_win);
    _ = c.delwin(local_win);
}
