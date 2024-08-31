const std = @import("std");
const print = std.debug.print;
const alloc = std.heap.page_allocator;

pub fn main() !void {
    const str: []u8 = try alloc.alloc(u8, 512);
    defer alloc.free(str);

    var user = User{ .id = 1, .power = 100, .name = "Gocky" };
    levelUp(&user);

    print("User {d} - {s} has power {d}\n", .{ user.id, user.name, user.power });
    print("User -> {*}, user.id -> {*}, user.power -> {*}\n", .{ &user, &user.id, &user.power });
    print("Alloced string addres is -> {*}, addres of ptr is {*}, address of len is {*}\n", .{ &str, &str.ptr, &str.len });
    // _ = strcpy(str, "Hello");
    // print("Alloced string addres is -> {*}, addres of ptr is {*}, address of len is {*}\n", .{ &str, &str.ptr, &str.len });
    print("User {*}\n, user.id {*}\n, user.power {*}\n, user.name {*}\n", .{ &user, &user.id, &user.power, &user.name });
}

fn levelUp(user: *User) void {
    user.power += 1;
}

pub const User = struct {
    id: u64,
    power: i32,
    name: []const u8,
};

pub fn strcpy(dest: anyopaque, str: anyopaque) i32 {
    for (str, 0..) |c, i| {
        dest[i] = str[i];
        if (c == 0) return i;
    }
    return -1;
}
