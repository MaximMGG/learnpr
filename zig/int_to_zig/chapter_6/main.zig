const std = @import("std");

const User = struct {
    id: u64,
    name: []const u8,
    email: []const u8,

    fn init(id: u64, name: []const u8, email: []const u8) User {
        return User{ .id = id, .name = name, .email = email };
    }
    fn print_name(self: *User) void {
        std.debug.print("Name of user: {s}\n", .{self.name});
    }
};

pub fn main() !void {
    const number: u8 = 5;
    const pointer = &number;
    _ = pointer;

    const user = User{ .id = 1, .name = "Pedro", .email = "pedro@gmail.com" };
    const user_p = &user;
    @constCast(user_p).print_name();

    var v_user = User{ .id = 2, .name = "Raul", .email = "raul@gmail.com" };
    v_user.id = 5;
    v_user.print_name();
    std.debug.print("{any}\n", .{@TypeOf(user_p)});
    std.debug.print("{any}\n", .{@TypeOf(&v_user)});
    const v_user_p: *User = &v_user;

    v_user_p.id = 9;

    std.debug.print("{any}\n", .{v_user_p.*});

    const arr = [_]i32{ 1, 4, 7, -1 };
    var arr_p: [*]const i32 = &arr;
    for (0..4) |i| {
        std.debug.print("{d}\n", .{arr[i]});
    }
    _ = &arr_p;

    const u = [_]User{ User{ .id = 1, .name = "a", .email = "a@.com" }, User{ .id = 2, .name = "b", .email = "b@.com" } };
    const @"u2": [*]const User = &[_]User{ User{ .id = 3, .name = "c", .email = "c@.com" }, User{ .id = 4, .name = "d", .email = "d@.com" } };
    var @"u3": [*]User = @constCast(&[_]User{ User{ .id = 5, .name = "e", .email = "e@.com" }, User{ .id = 6, .name = "f", .email = "f@.com" } });
    defer _ = &@"u3";

    std.debug.print("{any}\n", .{@TypeOf(u)});
    std.debug.print("{any}\n", .{@TypeOf(@"u2")});
    std.debug.print("{any}\n", .{@TypeOf(@"u3")});

    const u_p: [*]const User = &u;

    for (0..2) |i| {
        const tmp_u: *const User = &(u_p + i)[0];
        std.debug.print("{any}\n", .{tmp_u.*});
    }

    for (0..2) |i| {
        const tmp_u = &(@"u2" + i)[0];
        std.debug.print("{any}\n", .{tmp_u.*});
    }

    for (0..2) |i| {
        const tmp_u = &(@"u3" + i)[0];
        std.debug.print("{any}\n", .{tmp_u.*});
    }

    optional();
}

fn optional() void {
    var num: ?u32 = 0;
    num = null;

    num = return_null(4) orelse 12;
    std.debug.print("{d}\n", .{num.?});
    num = return_null(5) orelse 12;
    std.debug.print("{d}\n", .{num.?});

    num = return_null(4);
    if (num) |not_null_num| {
        std.debug.print("{d}\n", .{not_null_num});
    } else {
        std.debug.print("num is null\n", .{});
    }

    num = return_null(5);

    if (num) |not_null_num| {
        std.debug.print("{d}\n", .{not_null_num});
    } else {
        std.debug.print("num is null\n", .{});
    }

    const num2 = return_null(5) orelse blk: {
        const i: u32 = 33;
        break :blk i * 4;
    };
    std.debug.print("num2: {d}\n", .{num2});
}

fn return_null(num: u32) ?u32 {
    if (num % 2 == 0) {
        return num % 2;
    } else {
        return null;
    }
}
