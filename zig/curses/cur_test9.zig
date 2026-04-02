const std = @import("std");
const c = @cImport({@cInclude("ncurses.h");});

const WIDTH: c_int = 30;
const HEIGHT: c_int = 10;

var startx: c_int = 0;
var starty: c_int = 0;

const choices = [_][]const u8 {
    "Choice 1",
    "Choice 2",
    "Choice 3",
    "Choice 4",
    "Exit",

};

pub fn main() !void {
    var ch: c_int = 0;
    var choice: c_int = 0;
    var menu_win: *c.WINDOW = undefined;
    var event: c.MEVENT = undefined;

    _ = c.initscr() orelse return error.InitscrError;
    _ = c.clear();
    _ = c.noecho();
    _ = c.cbreak();
    startx = @divTrunc(80 - WIDTH, 2);
    starty = @divTrunc(24 - HEIGHT, 2);

    _ = c.attron(c.A_REVERSE);
    _ = c.mvprintw(23, 1, "Click on Exit to quit (Works best in a virtual console)");
    _ = c.refresh();
    _ = c.attroff(c.A_REVERSE);

    menu_win = c.newwin(HEIGHT, WIDTH, starty, startx);
    print_menu(menu_win, 1);
    _ = c.mousemask(c.ALL_MOUSE_EVENTS, null);

    while(ch != c.KEY_F(1)) {
        ch = c.wgetch(menu_win);
        switch(ch) {
            c.KEY_MOUSE => {
                if (c.getmouse(&event) == c.OK) {
                    report_choice(event.x + 1, event.y + 1, &choice);
                    if (choice == -1) {
                        break;
                    }
                    _ = c.mvprintw(22, 1, "Choice made is: %d String choisen is: %s \"%10s\"", 
                        choice, choices[@intCast(choice - 1)].ptr);
                    _ = c.refresh();
                }
                print_menu(menu_win, choice);
                break;
            },
            else => {}
        }
    }
    _ = c.getch();
    _ = c.endwin();
}


fn print_menu(menu_win: *c.WINDOW, highlight: c_int) void {

    const x: c_int = 2;
    var y: c_int = 2;
    var i: c_int = 0;
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

fn report_choice(mouse_x: c_int, mouse_y: c_int, p_choice: *c_int) void {
    const i: c_int = startx + 2;
    const j: c_int = starty + 3;

    var choice: c_int = 0;
    while(choice < choices.len) : (choice += 1) {
        if (mouse_y == j + choice and mouse_x >= i and mouse_x <= i + @as(c_int, @intCast(choices[@intCast(choice)].len))) {
            if (choice == choices.len - 1) {
                p_choice.* -= 1;
            } else {
                p_choice.* = choice + 1;
            }
            break;
        }
    }
}
