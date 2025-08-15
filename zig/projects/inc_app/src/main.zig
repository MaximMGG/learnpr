const std = @import("std");
const builtin = @import("builtin");
const Logger = std.filelog.Logger;
const c = @cImport({
    @cInclude("ncurses.h");
});

const PATH_TO_FILE = "/home/{s}/.config/incfile.inc";
var incFile: std.fs.File = undefined;
var def_name_buf: [512]u8 = .{0} ** 512;
var def_name: []u8 = undefined;

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
    difference: i32,

    fn toString(self: *item, buf: []u8) ![]const u8 {
        const item_string = try std.fmt.bufPrint(buf, "{s: <20}  {d: ^20} {d: ^20} {d: ^20}",
            .{self.name, self.current_consumption, self.limit, self.difference}
        );
        return item_string;
    }
};

fn prepareDefNameString() !void {
    def_name = try std.fmt.bufPrint(&def_name_buf, "{s: <30} {s: ^30} {s: ^30} {s: ^30}", 
        .{"Cosumption name", "Current consumption", "Limit", "Difference"});

}

pub fn main() !void {

    const allocator = std.heap.page_allocator;
    var logger = try Logger.init("inc.log");
    defer logger.deinit();

    _ = c.initscr() orelse return error.InitScrFailed;
    _ = c.noecho();
    _ = c.raw();
    _ = c.keypad(c.stdscr, true);
    _ = c.start_color();

    _ = c.init_pair(1, c.COLOR_RED, c.COLOR_BLACK);
    _ = c.init_pair(2, c.COLOR_GREEN, c.COLOR_BLACK);

    _ = c.refresh();
    var ch: c_int = 0;
    var cursore: usize = 0;
    _ = &cursore;
    try prepareDefNameString();
    try logger.log(.INFO, @src(), "prepareDefNameString", .{});
    //var item_buf: [512]u8 = .{0} ** 512;
    var item_list = try readIncFile(allocator);
    try logger.log(.INFO, @src(), "readIncFile", .{});
    defer item_list.deinit();

    while(ch != c.KEY_F(1)) : (ch = c.getch()) {
        _ = c.clear();
        _ = c.mvprintw(0, 0, "%s", def_name.ptr);

        // for(item_list.items, 0..item_list.items.len) |*it, i| {
        //     if (i == cursore) {
        //         _ = c.attron(c.A_REVERSE);
        //         const item_str = try it.toString(&item_buf);
        //         _ = c.mvprintw(@intCast(i + 1), 0, "%s", item_str.ptr);
        //         @memset(&item_buf, 0);
        //         _ = c.attroff(c.A_REVERSE);
        //     } else {
        //         const item_str = try it.toString(&item_buf);
        //         _ = c.mvprintw(@intCast(i + 1), 0, "%s", item_str.ptr);
        //         @memset(&item_buf, 0);
        //     }
        // }

        _ = c.mvprintw(c.LINES - 1, 0, "Press h for help");

        switch(ch) {
            'j' => {
                if (cursore < item_list.items.len) {
                    cursore += 1;
                }
            },
            'k' => {
                if (cursore > 0) {
                    cursore -= 1;
                }
            },
            'q' => {
                break;
            },
            else => {}
        }

        _ = c.refresh();
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

