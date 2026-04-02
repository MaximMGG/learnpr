const std = @import("std");
const json = std.json;
const c = @cImport(@cInclude("ncurses.h"));

const Window = struct {
    window: *c.WINDOW = undefined,

    pub fn init(self: *Window) Window {
        self.w = c.initscr().?;
        _ = c.raw();
        _ = c.noecho();
        _ = c.keypad(self.w, true);
        _ = c.refresh();
    }

    pub fn parseConfig(self: *Window) !void {

    }

    pub fn deinit(self: *Window) void {
        _ = self;
        _ = c.endwin();
    }
};
