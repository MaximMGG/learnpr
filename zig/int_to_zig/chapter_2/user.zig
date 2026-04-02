const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub const User = struct {
    id: u64,
    name: []const u8,
    email: []const u8,

    pub fn init(id: u64, name: []const u8, email: []const u8) User {
        return User{ .id = id, .name = name, .email = email };
    }

    pub fn print_name(self: User) !void {
        try stdout.print("User name: {s}\n", .{self.name});
    }

    pub fn change_id(self: *User, new_id: u64) void {
        self.id = new_id;
    }
};
