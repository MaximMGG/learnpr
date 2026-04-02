const std = @import("std");
const c = @cImport(@cInclude("panel.h"));

pub fn main() !void {
    var my_wins: [3]*c.WINDOW = undefined;
    var panels: [3]*c.PANEL = undefined;
    const lines: c_int = 10;
    const cols: c_int = 40;
    const y: c_int = 2;
    const x: c_int = 4;
    var i: usize = 0;

    _ = c.initscr() orelse return error.InitscrError;
    _ = c.cbreak();
    _ = c.noecho();

    my_wins[0] = c.newwin(lines, cols, y, x) orelse return error.NewwinError;
    my_wins[1] = c.newwin(lines, cols, y + 1, x + 5) orelse return error.NewwinError;
    my_wins[2] = c.newwin(lines, cols, y + 2, x + 10) orelse return error.NewwinError;

    while(i < 3) : (i += 1) {
        _ = c.box(my_wins[i], 0, 0);
    }

    panels[0] = c.new_panel(my_wins[0]) orelse return error.NewpanelError;
    panels[1] = c.new_panel(my_wins[1]) orelse return error.NewpanelError;
    panels[2] = c.new_panel(my_wins[2]) orelse return error.NewpanelError;

    c.update_panels();

    _ = c.doupdate();
    _ = c.getch();

    _ = c.endwin();
}
