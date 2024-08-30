const std = @import("std");

pub fn main() void {
    const user = User{
        .power = 666,
        .name = "Kolya",
    };

    std.debug.print("{s} has power: {d}\n", .{ user.name, user.power });
    const a = @as(u64, 123);
    const b = 321;
    const e: u64 = 444;
    const c = add(@as(i64, a), b);
    const d = add(b, e);
    std.debug.print("{d} + {d} = {d}\n", .{ a, b, c });
    std.debug.print("u64 {d} + {d} = {d}\n", .{ b, e, d });

    const user2 = User{
        .power = 10000,
        .name = "Bibus",
    };
    user2.diagnose();
    User.diagnose(user);

    const user3 = User.init("Mark", 111);
    user3.diagnose();
}

pub const User = struct {
    power: u64,
    name: []const u8,

    pub const SUPER_POWER = 9999;

    pub fn init(name: []const u8, power: u64) User {
        return User{
            .name = name,
            .power = power,
        };
    }

    fn diagnose(user: User) void {
        if (user.power > SUPER_POWER) {
            std.debug.print("A lot of power of {s} -> {d}\n", .{ user.name, user.power });
        } else {
            std.debug.print("User: {s}, has power is {d}\n", .{ user.name, user.power });
        }
    }
};

pub fn add(a: i64, b: i64) i64 {
    return a + b;
}
