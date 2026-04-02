const std = @import("std");
const mem = std.mem;


pub const RED = "\x1b[31m";
pub const RESET = "\x1b[0m";
pub const GREEN = "\x1b[32m";
pub const YELLOW = "\x1b[33m";
pub const MAGENTA = "\x1b[35m";
pub const CYAN = "\x1b[36m";
pub const BLUE = "\x1b[34m";
pub const ORANGE = "\x1b[38;2;206;145;120m";
pub const GREY = "\x1b[38;2;156;156;156m";
pub const CREAM = "\x1b[38;2;220;220;145m";
pub const LIGHT_GREEN = "\x1b[38;2;181;206;143m";
pub const LIGHT_BLUE = "\x1b[38;2;5;169;173m";
pub const PEACH = "\x1b[38;2;255;231;190m";


pub fn printNumberSlice(comptime T: type, input: []const T) void {
    std.debug.print("{any}", .{input});
}

pub fn printlnNumberSlice(comptime T: type, input: []const T) void {
    std.debug.print("{any}\n", .{input});
}

pub fn printlnQuotes(input: []const u8) void {
    std.debug.print("'{s}'\n", .{input});
}

pub fn twoSlicesAreTheSame(first_slice: []const u8, second_slice: []const u8) bool {
    return mem.eql(u8, first_slice, second_slice);
}

