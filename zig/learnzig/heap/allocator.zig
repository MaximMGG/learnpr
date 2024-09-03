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
}

pub const User = struct {
    id: u64,
    power: i32,
};

fn levelUp(user: *User) void {
    user.id += 1;
}
