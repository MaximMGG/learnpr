const std = @import("std");

const pi: f64 = 3.141592;
const greets = "Hello";

var count: usize = 0;

const TestError = error{
    Boom,
};
fn locals() u8 {
    const a: u8 = 1;
    const b: u8 = 2;
    const result: u8 = a + b;
    return result;
}

//this is really bad idea
fn badIdea1() *u8 {
    const x: u8 = 42;
    return &x;
}

fn badIdea2() []u8 {
    const array: [5]u8 = .{ 'H', 'e', 'l', 'l', 'o' };
    const arr = array[2..];
    return arr;
}

fn goodIdea(allocator: std.mem.Allocator) std.mem.Allocator.Error![]u8 {
    const array: [5]u8 = .{ 'H', 'e', 'l', 'l', 'o' };
    const s = try allocator.alloc(u8, 5);
    std.mem.copyForwards(u8, s, &array);
    return s;
}

fn catOutVarLen(a: []const u8, b: []const u8, out: []u8) usize {
    std.debug.assert(out.len >= a.len + b.len);

    std.mem.copyForwards(u8, out, a);
    std.mem.copyForwards(u8, out[a.len..], b);

    return a.len + b.len;
}

test "catOutVarLen" {
    const hello: []const u8 = "Hello ";
    const world: []const u8 = "world!";

    var out: [128]u8 = undefined;
    const len: usize = catOutVarLen(hello, world, &out);
    try std.testing.expect(len == 12);
    try std.testing.expectEqualStrings(hello ++ world, out[0..len]);
}

fn catOutVarSlice(a: []const u8, b: []const u8, out: []u8) []u8 {
    std.debug.assert(out.len >= a.len + b.len);

    std.mem.copyForwards(u8, out, a);
    std.mem.copyForwards(u8, out[a.len..], b);

    return out[0 .. a.len + b.len];
}
test "catOutVarSlice" {
    const hello: []const u8 = "Hello ";
    const world: []const u8 = "world!";

    var out: [128]u8 = undefined;
    const new: []u8 = catOutVarSlice(hello, world, &out);
    try std.testing.expectEqualStrings(hello ++ world, new[0..]);
}

fn catAlloc(allocator: std.mem.Allocator, a: []const u8, b: []const u8) ![]u8 {
    const buf: []u8 = try allocator.alloc(u8, a.len + b.len);
    std.mem.copyForwards(u8, buf, a);
    std.mem.copyForwards(u8, buf[a.len..], b);
    errdefer allocator.free(buf);
    //try errBoom();

    return buf;
}

fn errBoom() TestError!void {
    return TestError.Boom;
}
test "catAlloc" {
    const hello: []const u8 = "Hello ";
    const world: []const u8 = "world!";
    const allocator = std.testing.allocator;

    const buf: []u8 = try catAlloc(allocator, hello, world);
    defer allocator.free(buf);

    try std.testing.expectEqualStrings(hello ++ world, buf);
}

const Foo = struct {
    s: []u8,
    var _allocator: std.mem.Allocator = undefined;

    fn init(allocator: std.mem.Allocator, s: []const u8) !*Foo {
        const foo_ptr = try allocator.create(Foo);
        errdefer allocator.destroy(foo_ptr);

        foo_ptr.s = try allocator.alloc(u8, s.len);
        std.mem.copyForwards(u8, foo_ptr.s, s);

        _allocator = allocator;
        return foo_ptr;
    }

    fn deinit(self: *Foo) void {
        _allocator.free(self.s);
        _allocator.destroy(self);
    }
};

test Foo {
    const allocator = std.testing.allocator;
    const foo = try Foo.init(allocator, "Super Foo");
    defer foo.deinit();

    try std.testing.expectEqualStrings("Super Foo", foo.s);
    std.debug.print("Size of Foo: {}\n", .{@sizeOf(Foo)});
}

pub fn main() !void {}
