const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
    @cInclude("stdlib.h");
});

pub fn main () !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    var row: c_int = 0;
    var col: c_int = 0;
    var prev: u8 = 0;
    var x: c_int = 0;
    var y: c_int = 0;
    var ch: u8 = 0;

    std.debug.print("{s}\n", .{args[1]});
    const file = try std.fs.cwd().openFile(args[1], .{.mode = .read_only});
    defer file.close();
    const f_reader = file.reader();

    const stdscr = c.initscr() orelse return error.InitscrError;
    _ = c.noecho();
    _ = c.raw();
    row = c.getmaxy(stdscr);
    col = c.getmaxx(stdscr);
    while(true) {
        ch = f_reader.readByte() catch |err| {
            switch(err) {
                error.EndOfStream => {
                    break;
                },
                else => {
                    return err;
                }
            }
        };
        if (y == (row - @as(c_int, 1))) {
            _ = c.printw("<-Press any key->");
            _ = c.getch();
            _ = c.clear();
            _ = c.move(0, 0);
        }
        if (prev == @as(c_int, '/') and ch == @as(c_int, '*')) {
            _ = c.attron(c.A_BOLD);
            x = c.getcurx(stdscr);
            y = c.getcury(stdscr);
            _ = c.move(y, x - @as(c_int, 1));
            _ = c.printw("%c%c", @as(u8, '/'), ch);
        } else {
            _ =c.printw("%c", ch);
        }
        _ = c.refresh();

        if (prev == @as(c_int, '/') and ch == @as(c_int, '*')) {
            _ = c.attroff(c.A_BOLD);
        }
        prev = ch;
        _ = c.getch();
    }

    _ = c.endwin();
}
