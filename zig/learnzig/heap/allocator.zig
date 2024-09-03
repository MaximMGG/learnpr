const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alc = gpa.allocator();

    var user: *User = try alc.create(User);
    defer alc.destroy(user);

    user.id = 1;
    user.power = 100;

    levelUp(user);
    std.debug.print("User {d}, has power {d}\n", .{ user.id, user.power });

    var u = try User.init(alc, 33, 10000);

    std.debug.print("User {d}, has power {d}\n", .{ u.id, u.power });
    defer u.deinit(alc);
}

pub const User = struct {
    id: u64,
    power: i32,

    fn init(allocator: std.mem.Allocator, id: u64, power: i32) !*User {
        const user = try allocator.create(User);
        user.* = .{ .id = id, .power = power };
        return user;
    }

    fn deinit(self: *User, allocator: std.mem.Allocator) void {
        allocator.destroy(self);
    }
};

fn levelUp(user: *User) void {
    user.id += 1;
}
