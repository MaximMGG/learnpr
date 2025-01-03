const std = @import("std");

pub fn main() !void {
    const user = userFactory(.{ .id = 1, .power = 123, .active = true, .name = "Petro" });
    const user2 = userFactory(.{});

    std.debug.print("{any}\n", .{user});
    std.debug.print("{any}\n", .{user2});
}

pub fn userFactory(data: anytype) User {
    const T = @TypeOf(data);
    return .{
        .id = if (@hasField(T, "id")) data.id else 0,
        .power = if (@hasField(T, "power")) data.power else 0,
        .active = if (@hasField(T, "active")) data.active else false,
        .name = if (@hasField(T, "name")) data.name else "",
    };
}

pub const User = struct { id: u64, power: u64, active: bool, name: []const u8 };
