const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
});

const PATH_TO_FILE = "/home/{s}/.config/incfile.inc";
const incFile: std.fs.File = undefined;

fn checkIncFile() !void {
    const allocator = std.heap.page_allocator;

    var env = try std.process.getEnvMap(allocator);
    defer env.deinit();
    const user = env.get("USER").?;

    var buf: [128]u8 = .{0} ** 128;

    const path = try std.fmt.bufPrint(&buf, PATH_TO_FILE, .{user});

    if (std.posix.access(path, std.c.F_OK)) {
        incFile = try std.fs.openFileAbsolute(path, .{.mode = .read_wirte});
        return;
    } else |_| {
        incFile = try std.fs.createFileAbsolute(path, .{});
    }
}


fn readIncFile(allocator: std.mem.Allocator) !std.HashMap(*item) {
    const f_stat = try incFile.stat();
    if (f_stat.size == 0) {
        return error.IncFileEmpty;
    } 

    const r = incFile.reader();
}


const item = struct {
    name: [64]u8,
    current_consumption: u32,
    limit: u32,
    difference: i32
};

pub fn main() !void {
    _ = c.initscr() orelse return error.InitScrFailed;
    _ = c.noecho();
    _ = c.raw();
    _ = c.keypad(c.stdscr, true);
    _ = c.start_color();

    _ = c.init_pair(1, c.COLOR_RED, c.COLOR_BLACK);
    _ = c.init_pair(2, c.COLOR_GREEN, c.COLOR_BLACK);

    _ = c.refresh();
    var ch: c_int = 0;


    while(ch != c.KEY_F(1)) : (ch = c.getch()) {

    }


    _ = c.endwin();
}

