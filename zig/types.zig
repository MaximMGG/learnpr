const print = std.debug.print;
const std = @import("std");
const os = std.os;
const assert = std.debug.assert;

pub fn main() void {
    const one_plus_one: i32 = 1 + 1;
    print("1 + 1 = {}\n", .{one_plus_one});

    const seven_div_three: f32 = 7.0 / 3.0;
    print("7.0 / 3.0 = {}\n", .{seven_div_three});

    print("{}\n{}\n{}\n", .{true and false, true or false, !true});

    var optional_value: ?[]const u8 = null;
    assert(optional_value == null);

    print("/noptional 1\ntype: {}\nvalue: {?s}", .{@TypeOf(optional_value), optional_value});
    optional_value = "Hi";
    assert(optional_value != null);
    print("\noptional 2\ntype: {}\nvalue: {?s}", .{@TypeOf(optional_value), optional_value});

    var numver_or_error: anyerror!i32 = error.ArgNotFound;

    print("\nerror union 1\ntype: {}\nvalue: {!}\n", .{@TypeOf(numver_or_error), numver_or_error});

    numver_or_error = 1234;

    print("\nerror union 2\ntype: {}\nvalue: {!}\n", .{@TypeOf(numver_or_error), numver_or_error});



}

