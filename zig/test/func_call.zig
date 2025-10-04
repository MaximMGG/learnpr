const std = @import("std");


fn first_print() void {

    std.debug.print("FIRST\n", .{});
}

fn second_print() void {
    std.debug.print("SECOND\n", .{});
}


fn test_func(a: u32, b: f32) void {
    std.debug.print("A: {d}, B: {d}", .{a, b});
}


pub fn GLCALL(func: *fn (args: anytype)void, args: anytype) void {
    first_print();

    const t = @typeInfo(@TypeOf(args));
    if (t != std.builtin.Type.Struct) {
        std.debug.print("Workd only with tuples");
    }
    //const args_type_info = t.@"struct".fields;

    if (func(args)) {
        std.debug.print("ERROR\n", .{});
    }
    second_print();
}



pub fn main() !void {
    GLCALL(test_func, .{12, 1.0});
}
