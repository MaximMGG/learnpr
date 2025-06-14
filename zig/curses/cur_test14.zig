const std = @import("std");
const c = @cImport(@cInclude("panel.h"));

const PANEL_DATA = struct {
    x: c_int = 0,
    y: c_int = 0,
    w: c_int = 0,
    h: c_int = 0,
    label: [80]u8,
    label_color: c_int,
    next: *c.PANEL,
};

const NLINES: c_int = 10;
const NCOLS: c_int = 40;

pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();


    var my_wins: [3]*c.WINDOW = undefined;
    var my_panels: [3]*c.PANEL = undefined;
    var top: *PANEL_DATA = undefined;
    var stack_top: *c.PANEL = undefined;
    var old_win: *c.WINDOW = undefined;
    var temp_win: *c.WINDOW = undefined;
    var ch: c_int = 0;
    var newx, var newy, var neww, var newh = @as([4]c_int, .{0} ** 4);
    var size = false;
    var move = false;

    _ = c.initscr() orelse return error.InitscrError;
    _ = c.start_color();
    _ = c.cbreak();
    _ = c.noecho();
    _ = c.keypad(c.stdscr.?, true);

    _ = c.init_pair(1, c.COLOR_RED, c.COLOR_BLACK);
    _ = c.init_pair(2, c.COLOR_GREEN, c.COLOR_BLACK);
    _ = c.init_pair(2, c.COLOR_BLUE, c.COLOR_BLACK);
    _ = c.init_pair(2, c.COLOR_CYAN, c.COLOR_BLACK);

    try init_wins(&my_wins);

    my_panels[0] = c.new_panel(my_wins[0]) orelse return error.NewPanelError;
    my_panels[1] = c.new_panel(my_wins[1]) orelse return error.NewPanelError;
    my_panels[2] = c.new_panel(my_wins[2]) orelse return error.NewPanelError;

    try set_user_ptrs(allocator, &my_panels);

    c.update_panels();

    _ = c.attron(c.COLOR_PAIR(4));
    _ = c.mvprintw(c.LINES - 3, 0, "Use 'm' for moving, 'r' for resizing");
    _ = c.mvprintw(c.LINES - 2, 0, "Use tab to browse through the windows (F1 ot Exit)");
    _ = c.attroff(c.COLOR_PAIR(4));
    _ = c.doupdate();


    stack_top = my_panels[2];
    top = @constCast(@alignCast(@ptrCast(c.panel_userptr(stack_top).?)));
    newx = top.x;
    newy = top.y;
    neww = top.w;
    newh = top.h;

    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        switch(ch) {
            9 => {
                top = @constCast(@alignCast(@ptrCast(c.panel_userptr(stack_top).?)));
                _ = c.top_panel(top.next);
                top = @constCast(@alignCast(@ptrCast(c.panel_userptr(stack_top).?)));
                newx = top.x;
                newy = top.y;
                neww = top.w;
                newh = top.h;
            },
            @as(c_int, 'r') => {
                size = true;
                _ = c.attron(c.COLOR_PAIR(4));
                _ = c.mvprintw(c.LINES - 4, 0, "Entered Resizing :Use Arrow Keys to reisze and press <ENTER> to end resizeing");
                _ = c.refresh();
                _ = c.attroff(c.COLOR_PAIR(4));
            },
            @as(c_int, 'm') => {
                _ = c.attron(c.COLOR_PAIR(4));
                _ = c.mvprintw(c.LINES - 4, 0, "Entered Moving: Use Arrow keys to Move and press <ENTER> to end moving");
                _ = c.refresh();
                _ = c.attroff(c.COLOR_PAIR(4));
                move = true;
            },
            c.KEY_LEFT => {
                if (size == true) {
                    newx -= 1;
                    neww += 1;
                }
                if (move == true) {
                    newx -= 1;
                }
            },
            c.KEY_RIGHT => {
                if (size == true) {
                    newx += 1;
                    neww -= 1;
                }
                if (move == true) {
                    newx += 1;
                }
            },
            c.KEY_UP => {
                if (size == true) {
                    newy -= 1;
                    newh += 1;
                }
                if (move == true) {
                    newy -= 1;
                }
            },
            c.KEY_DOWN => {
                if (size == true) {
                    newy += 1;
                    newh -= 1;
                }
                if (move == true) {
                    newy += 1;
                }
            },
            10 => {
                _ = c.move(c.LINES - 4, 0);
                _ = c.clrtoeol();
                _ = c.refresh();
                if (size == true) {
                    old_win = c.panel_window(stack_top).?;
                    temp_win = c.newwin(newh, neww, newy, newx).?;
                    _ = c.replace_panel(stack_top, temp_win);
                    win_show(temp_win, &top.label, top.label_color);
                    _ = c.delwin(old_win);
                    size = false;
                }
                if (move == true) {
                    _ = c.move_panel(stack_top, newy, newx);
                    move = false;
                }
            },
            else => {}
        }
        _ = c.attron(c.COLOR_PAIR(4));
        _ = c.mvprintw(c.LINES - 3, 0, "Use 'm' for moving, 'r' for resizing");
        _ = c.mvprintw(c.LINES - 2, 0, "Use tab to browse through the windows (F1 to Exit)");
        _ = c.attroff(c.COLOR_PAIR(4));
        _ = c.refresh();
        c.update_panels();
        _ = c.doupdate();
    }
    _ = c.endwin();
}

fn init_wins(wins: []*c.WINDOW) !void {
    var x, var y = @as([2]c_int, .{0} ** 2);
    var i: usize = 0;
    var label: [80]u8 = undefined;
    y = 2;
    x = 10;
    while(i < wins.len) : (i += 1) {
        wins[i] = c.newwin(NLINES, NCOLS, y, x) orelse return error.NewwinError;
        const label_name = try std.fmt.bufPrint(&label, "Window number: {d}", .{i + 1});
        win_show(wins[i], label_name, @intCast(i + 1));
        y += 3;
        x += 10;

    }

}

fn win_show(win: *c.WINDOW, label_name: []u8, label_color: c_int) void {
    var startx, var starty, var heigth, var width = @as([4]c_int, .{0} ** 4);
    starty = c.getbegy(win);
    startx = c.getbegx(win);

    width = c.getmaxx(win);
    heigth = c.getmaxy(win);

    _ = c.box(win, 0, 0);
    _ = c.mvwaddch(win, 2, 0, c.NCURSES_ACS('t'));
    _ = c.mvwhline(win, 2, 1, c.NCURSES_ACS('q'), width - 2);
    _ = c.mvwaddch(win, 2, width - 1, c.NCURSES_ACS('u'));
    print_in_middle(win, 1, 0, width, label_name, c.COLOR_PAIR(label_color));

}

fn set_user_ptrs(allocator: std.mem.Allocator, panels: []*c.PANEL) !void {
    var ptrs: []PANEL_DATA = undefined;
    var win: *c.WINDOW = undefined;
    var x, var y, var w, var h = @as([4]c_int, .{0} ** 4);
    var i: usize = 0;
    var tmp: [80]u8 = undefined;
    ptrs = try allocator.alloc(PANEL_DATA, panels.len);
    defer allocator.free(ptrs);
    
    while(i < panels.len) : (i += 1) {
        win = c.panel_window(panels[i]).?;
        x = c.getbegx(win);
        y = c.getbegy(win);
        h = c.getmaxy(win);
        w = c.getmaxx(win);
        ptrs[i].x = x;
        ptrs[i].y = y;
        ptrs[i].w = w;
        ptrs[i].h = h;
        const win_number = try std.fmt.bufPrint(&tmp, "Window Number {d}", .{@as(usize, @intCast(i + 1))});
        std.mem.copyForwards(u8, ptrs[i].label[0..win_number.len], win_number);
        ptrs[i].label_color = @intCast(i + @as(usize, 1));
        if (i + 1 == panels.len) {
            ptrs[i].next = panels[0];
        } else {
            ptrs[i].next = panels[i + 1];
        }
        _ = c.set_panel_userptr(panels[i], &ptrs[i]);
    }
}

fn print_in_middle(_win: ?*c.WINDOW, starty: c_int, startx: c_int, _width: c_int,  string: []u8, color: c_int) void {
    var length, var x, var y = @as([3]c_int, .{0} ** 3);
    var win: *c.WINDOW = undefined;
    var width: c_int = 0;
    var temp: f32 = 0;


    if (_win == null) {
        win = c.stdscr.?;
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
    }

    length = @as(c_int, @intCast(string.len));
    temp = @as(f32, @floatFromInt(@divTrunc(width - length, 2)));
    x = startx + @as(c_int, @intFromFloat(temp));
    _ = c.wattron(win, color);
    _ = c.mvwprintw(win, y, x, "%s", string.ptr);
    _ = c.wattroff(win, color);
    _ = c.refresh();
}
