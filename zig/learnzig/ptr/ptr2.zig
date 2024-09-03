const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const leto = User{ .id = 1, .power = 9001, .manager = null };
    const duncan = User{ .id = 1, .power = 9001, .manager = &leto };

    print("{any}\n{any}\n", .{ leto, duncan });
}

pub fn levelUp(user: User) void {
    user.name[2] = '!';
}

pub const User = struct {
    id: u64,
    power: i32,
    manager: ?*const User,
};
