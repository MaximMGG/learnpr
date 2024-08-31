const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const save = (try Save.loadLast()) orelse Save.blank();
    print("{any}\n", .{save});
}

pub const Save = struct {
    lives: u8,
    level: u16,

    pub fn loadLast() !?Save {
        return null;
    }

    pub fn blank() Save {
        return .{
            .lives = 3,
            .level = 1,
        };
    }
};
