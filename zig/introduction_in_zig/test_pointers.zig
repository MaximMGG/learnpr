const std = @import("std");


const User = struct {
    id: i32,
    name: []const u8,
    email: []const u8,


    pub fn init(id: i32, name: []const u8, email: []const u8) User {
        return User{
            .id = id,
            .name = name,
            .email = email
        };
    }

};

pub fn main() !void {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    const allocator = std.heap.c_allocator;

    var users: [*]User = (try allocator.alloc(User, 5)).ptr;

    users[0] = User.init(0, "Huan", "qwer");
    users[1] = User.init(1, "qwe", "qwer");
    users[2] = User.init(2, "ijijf", "qwer");
    users[3] = User.init(3, "oij[[[]]]", "qwer");
    users[4] = User.init(4, "l,mvm,c", "qwer");

    for(users, 0..5) |u, i| {
        std.debug.print("User: {d}, id: {d}, name: {s}, email: {s}\n", .{i, u.id, u.name, u.email});
    }

    allocator.free(users[0..5]);

}
