const std = @import("std");
const expect = std.testing.expect;

test "allowzero" {
    var zero: usize = 0;
    _ = &zero;
    const ptr: *allowzero i32 = @ptrFromInt(zero);

    try expect(@intFromPtr(ptr) == 0);
}

pub extern "c" fn printf(fmt: [*:0]const u8, ...) c_int;

pub fn main() !void {
    _ = printf("Hello, world!\n");

    const msg = "Hello, world!\n";
    const non_null_terminates_msg: [msg.len]u8 = msg.*;
    _ = printf(&non_null_terminates_msg);
}
