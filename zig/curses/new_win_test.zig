const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
});


pub fn main() !void {

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();


    const stdscr = c.initscr() orelse return error.InitScrError;
    _ = c.noecho();
    _ = c.raw();
    _ = c.keypad(stdscr, true);

    var ch: c_int = 0;
    const max_y = c.getmaxy(stdscr);
    const max_x = c.getmaxx(stdscr);

    _ = c.printw("Hello this is main screen");
    _ = c.refresh();

    const buf = try create_win(allocator, 3, @divTrunc(max_x, 2), max_y - 10, @divTrunc(max_x, 4));


    _ = c.printw("Input was: %s", buf.ptr);

    ch = c.getch();

    _ = c.endwin();

    std.debug.print("Enter was {s}\n", .{buf});
    allocator.free(buf);
}



fn create_win(allocator: std.mem.Allocator, y_size: c_int, x_size: c_int, y_pos: c_int, x_pos: c_int) ![]u8 {
    const new_win = c.newwin(y_size, x_size, y_pos, x_pos) orelse return "";
    var buf = try allocator.alloc(u8, 128);
    @memset(buf, 0);
    var i: usize = 0;
    _ = c.box(new_win, 0, 0);

    _ = c.wrefresh(new_win);

    var ch: c_int = 0;
    _ = c.echo();
    _ = c.keypad(new_win, true);

    _ = c.wmove(new_win, 1, 1);
    ch = c.wgetch(new_win);
    while(ch != c.KEY_F(2)) : (ch = c.wgetch(new_win)){
        buf[i] = @intCast(ch);
        i += 1;
    }

    _ = c.wclear(new_win);
    _ = c.wborder(new_win, 
                @as(c.chtype, ' '),
                @as(c.chtype, ' '),
                @as(c.chtype, ' '),
                @as(c.chtype, ' '),
                @as(c.chtype, ' '),
                @as(c.chtype, ' '),
                @as(c.chtype, ' '),
                @as(c.chtype, ' '));
    _ = c.wrefresh(new_win);
    _ = c.delwin(new_win);

    return buf;
}
