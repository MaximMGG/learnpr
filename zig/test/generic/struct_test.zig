const std = @import("std");
const list = @import("list.zig");

const Person = struct {
    name: []const u8 = "Peter",
    age: u32 = 0,
    friends: []Person = &[_]Person{},
};

fn struct_reflect(comptime t: type, val: anytype) void {
    const fields = @typeInfo(t).@"struct".fields;

    const type_name = @typeName(t);
    const dot_index = std.mem.lastIndexOf(u8, type_name, ".").?;
    std.debug.print("Name of type: {s}\n", .{type_name[dot_index + 1..type_name.len]});



    
    inline for(fields) |f| {
        std.debug.print("{s}\n", .{f.name});
        const n = @field(val, f.name);
        switch(f.type) {
            u32 => {
                std.debug.print("u32 val -> {d}\n", .{n});
            },
            []const u8 => {
                std.debug.print("[]const u8 val -> {s}\n", .{n});
            },
            else => {
                std.debug.print("else val -> {any}\n", .{n});
            }
        }
    }
}


pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const val: *u32 = try allocator.create(u32);
    val.* = 333;
    const persons = try allocator.alloc(Person, 5);
    for(0.., persons) |i, *per| {
        per.* = Person{};
        per.age = @intCast(i + 10);
    }
    const p = Person{.age = val.*, .friends = persons};
    defer allocator.free(p.friends);
    struct_reflect(Person, p);

}
