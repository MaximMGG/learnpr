const std = @import("std");

const dog = struct {
    name: []const u8,
    age: u32
};

fn parse_tuple(t: anytype) void {
    const type_info = @typeInfo(@TypeOf(t));
    if (type_info != .@"struct") {
        @panic("Not a struct");
    }
    if (!type_info.@"struct".is_tuple) {
        @panic("not a tuple");
    }
    std.debug.print("{s}\n", .{t[0]});
    std.debug.print("{d}\n", .{t[1]});

}

fn sey_type(t: anytype) void {
    const type_info = @typeInfo(@TypeOf(t));
    if (type_info == .@"struct") {
        for (type_info.@"struct".fields) |f| {
            const field = @field(t, f.name);
            std.debug.print("{any}\n", .{field});
        }

    }

}


pub fn main() void {
    parse_tuple(.{"Piter", 123});
    sey_type(dog);
}
