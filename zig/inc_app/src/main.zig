const std = @import("std");
const c = @cImport({
    @cInclude("ncurses.h");
});

const PATH_TO_FILE = "/home/{s}/.config/incfile.inc";
var incFile: std.fs.File = undefined;

fn checkIncFile() !void {
    const allocator = std.heap.page_allocator;

    var env = try std.process.getEnvMap(allocator);
    defer env.deinit();
    const user = env.get("USER").?;

    var buf: [128]u8 = .{0} ** 128;

    const path = try std.fmt.bufPrint(&buf, PATH_TO_FILE, .{user});

    if (std.posix.access(path, std.c.F_OK)) {
        incFile = try std.fs.openFileAbsolute(path, .{.mode = .read_write});
        return;
    } else |_| {
        incFile = try std.fs.createFileAbsolute(path, .{});
    }
}


fn readIncFile(allocator: std.mem.Allocator) !std.ArrayList(item) {
    var items = std.ArrayList(item).init(allocator);
    const f_stat = try incFile.stat();
    if (f_stat.size == 0) {
        return error.IncFileEmpty;
    } 

    const r = incFile.reader();
    while(r.readStruct(item)) |it| {
        try items.append(it);
    } else |_| {
    }

    return items;
}

fn writeIncFile(items: *std.ArrayList(item)) !void {
    try incFile.setEndPos(0);
    const writer = incFile.writer();

    for(items.items) |i| {
        try writer.writeStruct(i);
    }
}


const item = extern struct {
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

test "test read write sturct" {
    try checkIncFile();
    const allocator = std.testing.allocator;
    var items = std.ArrayList(item).init(allocator);
    defer items.deinit();
    var i: item = .{.name = undefined, .current_consumption = 999, .limit = 1000, .difference = 1};
    std.mem.copyForwards(u8, &i.name, "Bob");
    try items.append(i);
    try writeIncFile(&items);
    incFile.close();
    try checkIncFile();
    try readIncFile(allocator);

    incFile.close();
}

