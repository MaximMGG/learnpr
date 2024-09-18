const std = @import("std");
const builtin = @import("builtin");
const expect = std.testing.expect;

test "builtin.is_test" {
    try expect(isTest());
}

fn isTest() bool {
    return builtin.is_test;
}
