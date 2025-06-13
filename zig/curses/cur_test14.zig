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

}

fn init_wins(wins: []*c.WINDOW) !void {
    var x, var y, var i = @as([3]c_int, .{0} ** 3);
    var label: [80]u8 = undefined;
    y = 2;
    x = 10;
    while(i < @as(c_int, @intCast(wins.len))) : (i += 1) {
        wins[@intCast(i)] = c.newwin(NLINES, NCOLS, y, x) orelse return error.NewwinError;
        const label_name = try std.fmt.bufPrint(&label, "Window number: {d}", .{i + 1});
        win_show(wins[i], label_name, i + 1);
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

fn set_user_ptrs(allocator: std.mem.Allocator, panels: []*c.PANEL) void {
    var ptrs: []PANEL_DATA = undefined;
    var win: *c.WINDOW = undefined;
    var x, var y, var w, var h = @as([4]c_int, .{0} ** 4);
    var i: usize = 0;
    var tmp: [80]u8 = undefined;
    ptrs = try allocator.alloc(PANEL_DATA, panels.len);
    defer allocator.free(ptrs);
    
    while(i < panels.len) : (i += 1) {
        win = c.panel_window(panels[i]);
        x = c.getbegx(win);
        y = c.getbegy(win);
        h = c.getmaxy(win);
        w = c.getmaxx(win);
        ptrs[i].x = x;
        ptrs[i].y = y;
        ptrs[i].w = w;
        ptrs[i].h = h;
        const win_number = std.fmt.bufPrint(&tmp, "Window Number %d", .{i + 1});
        std.mem.copyForwards(u8, ptrs[i].label[0..win_number.len], win_number);
        ptrs[i].label_color = i + 1;
        if (i + 1 == panels.len) {
            ptrs[i].next = panels[0];
        } else {
            ptrs[i].next = panels[i + 1];
        }
        c.set_panel_userptr(panels[i], ptrs[i]);
    }
}

fn print_in_middle(_win: ?*c.WINDOW, starty: c_int, startx: c_int, _width: c_int,  string: []u8, color: c_int) void {
    var length, var x, var y = @as([3]c_int, .{0} ** 3);
    var win: *c.WINDOW = undefined;
    var width: c_int = 0;
    var temp: f32 = 0;


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
    }

    length = @as(c_int, @intCast(string.len));
    temp = @as(f32, @floatFromInt(@divTrunc(width - length, 2)));
    x = startx + @as(c_int, @intFromFloat(temp));
    _ = c.wattron(win, color);
    _ = c.mvwprintw(win, y, x, "%s", string.ptr);
    _ = c.wattroff(win, color);
    _ = c.refresh();
}
