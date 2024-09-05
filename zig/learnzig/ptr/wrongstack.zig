const std = @import("std");

pub fn main() void {
    const u = User.init(1, 2000);
    const ua = User.init(2, 2020);

    std.debug.print("User id {d}, user power {d}\n", .{ u.id, u.power });
    std.debug.print("User id {d}, user power {d}\n", .{ ua.id, ua.power });
}

pub const User = struct {
    id: u64,
    power: i32,

    fn init(id: u64, power: i32) *User {
        var user = User{ .id = id, .power = power };
        return &user;
    }
};
