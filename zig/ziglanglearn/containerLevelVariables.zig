var y: i32 = add(10, x);
const x: i32 = add(12, 34);

test "container level variables" {
    try expect(x == 46);
    try expect(y == 56);
}

fn add(a: i32, b: i32) i32 {
    return a + b;
}

const std = @import("std");
const expect = std.testing.expect;
const assert = std.debug.assert;

test "namespaced container level variable" {
    try expect(foo() == 1235);
    try expect(foo() == 1236);
}

const S = struct {
    var x: i32 = 1234;
};

fn foo() i32 {
    S.x += 1;
    return S.x;
}

test "static loal varibale" {
    try expect(foo2() == 1235);
    try expect(foo2() == 1236);
}

fn foo2() i32 {
    const I = struct {
        var x: i32 = 1234;
    };
    I.x += 1;
    return I.x;
}

threadlocal var z: i32 = 1234;

test "thread local storage" {
    const thread1 = try std.Thread.spawn(.{}, testTls, .{});
    const thread2 = try std.Thread.spawn(.{}, testTls, .{});
    testTls();
    thread1.join();
    thread2.join();
}

fn testTls() void {
    assert(z == 1234);
    z += 1;
    assert(z == 1235);
}
