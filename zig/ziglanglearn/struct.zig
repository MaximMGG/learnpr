const std = @import("std");
const assert = std.debug.assert;

const Point = struct { x: f32, y: f32 };

const Point2 = packed struct { x: f32, y: f32 };

const p = Point{ .x = 0.12, .y = 0.34 };

var p2 = Point{ .x = 0.12, .y = undefined };

const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn init(x: f32, y: f32, z: f32) Vec3 {
        return Vec3{ .x = x, .y = y, .z = z };
    }
    pub fn dot(self: Vec3, other: Vec3) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }
};

const expect = @import("std").testing.expect;

test "dot product" {
    const v1 = Vec3.init(1.0, 0.0, 0.0);
    const v2 = Vec3.init(0.0, 1.0, 0.0);
    try expect(v1.dot(v2) == 0.0);
}

const Empty = struct {
    pub const PI = 3.14;
};

test "struct namespaced variable" {
    try expect(Empty.PI == 3.14);
    try expect(@sizeOf(Empty) == 0);

    const does_nothing = Empty{};
    _ = does_nothing;
}

fn setYBasedOnX(x: *f32, y: f32) void {
    const point: *Point = @fieldParentPtr("x", x);
    point.y = y;
}
test "filed parent pointer" {
    var point = Point{ .x = 0.1234, .y = 0.5678 };
    setYBasedOnX(&point.x, 0.9);
    try expect(point.y == 0.9);
}

fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node,
            next: ?*Node,
            data: T,
        };
        first: ?*Node,
        last: ?*Node,
        len: usize,
    };
}

test "linked list" {
    try expect(LinkedList(i32) == LinkedList(i32));

    const list = LinkedList(i32){ .first = null, .last = null, .len = 0 };

    try expect(list.len == 0);

    const ListOfInts = LinkedList(i32);
    try expect(ListOfInts == LinkedList(i32));

    var node = ListOfInts.Node{
        .prev = null,
        .next = null,
        .data = 1234,
    };
    const list2 = LinkedList(i32){ .first = &node, .last = &node, .len = 1 };

    try expect(list2.first.?.data == 1234);
}

const Foo = struct {
    a: i32 = 1234,
    b: i32,
};

test "default struct initialization fields" {
    const x: Foo = .{ .b = 5 };
    if (x.a + x.b != 1239) {
        comptime unreachable;
    }
}

const Threshold = struct {
    minimum: f32,
    maximum: f32,

    const default: Threshold = .{ .minimum = 0.25, .maximum = 0.75 };

    const Category = enum { low, medium, high };

    fn categorize(t: Threshold, value: f32) Category {
        assert(t.maximum >= t.minimum);
        if (value < t.minimum) return .low;
        if (value > t.maximum) return .high;
        return .medium;
    }
};

pub fn main() !void {
    var threshold: Threshold = .{
        .maximum = 0.20,
    };

    const category = threshold.categorize(0.90);
    try std.io.getStdOut().writeAll(@tagName(category));
}
