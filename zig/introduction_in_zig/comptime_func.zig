const std = @import("std");




test "mult test" {
    try std.testing.expect(@call(.compile_time, mult, .{5, 8}) == 40);
}

fn mult(a: i32, b: i32) i32 {
    return a * b;
}
