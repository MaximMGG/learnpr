const std = @import("std");
const u = @import("user.zig");

const sex = enum(u32) {
    MALE, FEMALE
};

const zig_user = extern struct {
    id: i32,
    name: [*:0]const u8,
    email: [*: 0]const u8,
    s: sex,
};

pub extern "c" fn user_create(id: i32, name: [*:0]const u8, email: [*:0]const u8, s: sex) void;


pub fn main() !void {
    var user_a: u.user = user_create(0, "Pedro", "pedro@gmail.com", .MALE);
    u.user_print(@ptrCast(&user_a));

    var user_b: zig_user = .{.id = 0, .name = "Hulio", 
                .email = "Hulio@gmail.com", .s = sex.MALE};

    u.user_print(@ptrCast(&user_b));

}
