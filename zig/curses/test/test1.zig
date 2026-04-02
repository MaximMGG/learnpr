const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
});



const strings = [_][]const u8{  "The first string", 
                                "The second string", 
                                "The therd string", 
                                "The fours string", 
                                "The fives string"};

pub fn main() !void {
    const stdscr = c.initscr() orelse return error.InitScrError;
    _ = c.noecho();
    _ = c.raw();
    _ = c.keypad(stdscr, true);
    _ = c.start_color();
    var y: c_int = 0;
    var x: c_int = 0;
    x = 0;
    var cur_y: c_int = 0;
    var cur_x: c_int = 0;
    cur_x = 0;
    var ch: c_int = 0;

    _ = c.init_pair(1, c.COLOR_WHITE, c.COLOR_BLACK);
    _ = c.init_pair(2, c.COLOR_BLACK, c.COLOR_WHITE);

    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        _ = c.clear();
        switch(ch) {
            'j' => {
                if (cur_y == 4) {
                } else {
                    cur_y += @as(c_int, 1);
                }
            },
            'k' => {
                if (cur_y == 0) {
                } else {
                    cur_y -= @as(c_int, 1);
                }
            },
            else => {
            }
        }
        for(strings) |s| {
            if (y == cur_y and x == cur_x) {
                _ = c.attron(c.COLOR_PAIR(2));
                _ = c.mvprintw(y, x, "%s", s.ptr);
                y += @as(c_int, 1);
                _ = c.attroff(c.COLOR_PAIR(2));
            } else {
                _ = c.attron(c.COLOR_PAIR(1));
                _ = c.mvprintw(y, x, "%s", s.ptr);
                y += @as(c_int, 1);
                _ = c.attroff(c.COLOR_PAIR(1));
            }
        }
        y = 0;
    }
    _ = c.endwin();

}
