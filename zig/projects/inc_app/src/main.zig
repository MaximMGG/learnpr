const std = @import("std");
const builtin = @import("builtin");
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

    _ = c.initscr();



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

