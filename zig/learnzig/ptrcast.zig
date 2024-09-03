const std = @import("std");
const expect = std.testing.expect;

const Data = extern struct { a: i32, b: u8, c: f32, d: bool, e: bool };

test "cast" {
    const s = Data{ .a = 10001, .b = 12, .c = 23.44, .d = true, .e = false };

    const z = @as([*]const u8, @ptrCast(&s));

    try expect(@as(*const i32, @ptrCast(@alignCast(z))).* == 10001);
    try expect(@as(*const u8, @ptrCast(@alignCast(z + 4))).* == 12);
    try expect(@as(*const f32, @ptrCast(@alignCast(z + 8))).* == 23.44);
    try expect(@as(*const bool, @ptrCast(@alignCast(z + 12))).* == true);
    try expect(@as(*const bool, @ptrCast(@alignCast(z + 13))).* == false);
}

test "getlen" {
    const s = "Hello world!";
    const len = getlen(s);

    var arr: []u8 = undefined;
    arr.ptr = @as([*]u8, @ptrCast(try std.heap.page_allocator.alloc(u8, 24)));
    defer std.heap.page_allocator.free(arr.ptr);
    strcpy(arr.ptr, "Bybybyby");

    std.debug.print("{any}\n", .{@TypeOf(s)});
    std.debug.print("{any}\n", .{@TypeOf(s[0..])});
    std.debug.print("{any}\n", .{@TypeOf(arr)});
    std.debug.print("{s}\n", .{arr});
    try expect(len == s.len);
}

pub fn getlen(str: [*:0]const u8) usize {
    var i: usize = 0;
    while (str[i] != 0) : (i += 1) {}
    return i;
}

pub fn strcpy(src: [*]u8, dest: [*:0]const u8) void {
    var i: usize = 0;
    while (dest[i] != 0) : (i += 1) {
        src[i] = dest[i];
    }
}
