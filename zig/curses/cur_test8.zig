const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
});

const WIDTH: c_int = 30;
const HEIGHT: c_int = 10;

const choices = [_][]const u8 {
    "Choice 1",
    "Choice 2",
    "Choice 3",
    "Choice 4",
    "Exit"
};

var startx: c_int = 0;
var starty: c_int = 0;


pub fn main() !void {
    var menu_win: *c.WINDOW = undefined;
    var highlight: c_int = 1;
    var choice: c_int = 0;
    var _c: c_int = 0;

    _ = c.initscr() orelse return error.InitscrError;
    _ = c.clear();
    _ = c.noecho();
    _ = c.cbreak();
    startx = @divTrunc(80 - WIDTH, 2);
    starty = @divTrunc(24 - HEIGHT, 2);
    menu_win = c.newwin(HEIGHT, WIDTH, starty, startx);
    _ = c.keypad(menu_win, true);
    _ = c.mvprintw(0, 0, "Use arrow keys to go up and down, Press enter to select choice");
    _ = c.refresh();
    print_menu(menu_win, highlight);
    while(true) {
        _c = c.wgetch(menu_win);
        switch(_c) {
            c.KEY_UP => {
                if (highlight == 1) {
                    highlight = @intCast(choices.len);
                } else {
                    highlight -= 1;
                }
            },
            c.KEY_DOWN => {
                if (highlight == choices.len) {
                    highlight = 1;
                } else {
                    highlight += 1;
                }
            },
            @as(c_int, ' '),
            @as(c_int, 10) => {
                choice = highlight;
                _ = c.mvprintw(25, 0, "Your choice is = %s", choices[@intCast(choice - 1)].ptr);
                _ = c.refresh();
            },
            else => {
                _ = c.mvprintw(24, 0, "Character pressed is = %3d Hopefully it can be printed as '%c'", _c, @as(u8, @intCast(_c)));
                _ = c.refresh();
            }
        }
        print_menu(menu_win, highlight);
        if (choice == @as(c_int, @intCast(choices.len))) {
            break;
        }
    }
    _ = c.mvprintw(23, 0, "You choice %d with choice string %s\n", choice, choices[@intCast(choice - 1)].ptr);
    _ = c.clrtoeol();
    _ = c.refresh();
    _ = c.getch();
    _ = c.endwin();
}


fn print_menu(menu_win: *c.WINDOW, highlight: c_int) void {
    var i: c_int = 0;
    const x: c_int = 2;
    var y: c_int  = 2;
    _ = c.box(menu_win, 0, 0);
    while(i < choices.len) : (i += 1) {
        if (highlight == i + 1) {
            _ = c.wattron(menu_win, c.A_REVERSE);
            _ = c.mvwprintw(menu_win, y, x, "%s", choices[@intCast(i)].ptr);
            _ = c.wattroff(menu_win, c.A_REVERSE);
        } else {
            _ = c.mvwprintw(menu_win, y, x, "%s", choices[@intCast(i)].ptr);
        }
        y += 1;
    }
    _ = c.wrefresh(menu_win);
}
