const std = @import("std");

const Person = struct { name: *const [10]u8 = "Anton", surname: *const [10]u8 = "Hric", age: u32 = 33 };
const Vecotor = struct { x: u32, y: u32 };

pub fn main() void {
    const a = Person{ .name = "Anton", .surname = "Hrycenko", .age = 33 };
    //const x = Vecotor{ .x = 2, .y = 3 };
    foo(a);
    //foo(x);
}

fn foo(comptime str: anytype) void {
    if (std.mem.eql([]u8, @field(str, "name"), "Anton")) {
        std.debug.print("Yes\n", .{});
    }
}
