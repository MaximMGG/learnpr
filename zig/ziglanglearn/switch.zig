const std = @import("std");
const builtin = @import("builtin");
const expect = std.testing.expect;
const expectError = std.testing.expectError;

test "switch simple" {
    const a: u64 = 10;
    const zz: u64 = 103;

    const b = switch (a) {
        1, 2, 3 => 0,
        5...100 => 1,
        101 => blk: {
            const c: u64 = 5;
            break :blk c * 2 + 1;
        },
        zz => zz,
        blk: {
            const d: u32 = 5;
            const e: u32 = 100;
            break :blk d + e;
        } => 107,
        else => 9,
    };

    try expect(b == 1);
}

const os_msg = switch (builtin.target.os.tag) {
    .linux => "we found a linux user",
    else => "not a linux user",
};

test "switch inside function" {
    switch (builtin.target.os.tag) {
        .fuchsia => {
            @compileError("fuchsia not supported");
        },
        else => {},
    }
}

test "switch on tagged union" {
    const Point = struct {
        x: u8,
        y: u8,
    };
    const Item = union(enum) {
        a: u32,
        c: Point,
        d,
        e: u32,
    };

    var a = Item{ .c = Point{ .x = 1, .y = 2 } };

    const b = switch (a) {
        Item.a, Item.e => |item| item,
        Item.c => |*item| blk: {
            item.*.x += 1;
            break :blk 6;
        },
        Item.d => 8,
    };

    try expect(b == 6);
    try expect(a.c.x == 2);
}

const Color = enum { auto, off, on };

test "exhaustive switching" {
    const color = Color.off;
    const result = switch (color) {
        Color.auto => false,
        Color.on => false,
        Color.off => true,
    };
    try expect(result);
}

test "switch continue" {
    var sw: i32 = 5;
    while (true) {
        switch (sw) {
            5 => {
                sw = 4;
                continue;
            },
            2...4 => |v| {
                if (v > 3) {
                    sw = 2;
                    continue;
                } else if (v == 3) {
                    break;
                }
                sw = 1;
                continue;
            },
            1 => return,
            else => unreachable,
        }
    }
    try expect(sw == 1);
}

const Instruction = enum {
    add,
    mul,
    end,
};

fn evalueate(initial_stack: []const i32, code: []const Instruction) !i32 {
    var stack = try std.BoundedArray(i32, 8).fromSlice(initial_stack);
    var ip: usize = 0;

    return while (true) {
        switch (code[ip]) {
            .add => {
                try stack.append(stack.pop() + stack.pop());

                ip += 1;
                continue;
            },
            .mul => {
                try stack.append(stack.pop() * stack.pop());

                ip += 1;
                continue;
            },
            .end => {
                break stack.pop();
            },
        }
    };
}

test "evaluate" {
    const result = try evalueate(&.{ 7, 2, -3 }, &.{ .mul, .add, .end });

    try std.testing.expectEqual(1, result);
}

fn isFielsdOptional(comptime T: type, field_index: usize) !bool {
    const fields = @typeInfo(T).Struct.fields;
    return switch (field_index) {
        inline 0, 1 => |idx| @typeInfo(fields[idx].type) == .Optional,
        else => return error.IndexOutOfBounds,
    };
}

const Struct1 = struct { a: u32, b: ?u32 };

test "using @typeInfo with runtime values" {
    var index: usize = 0;
    try expect(!try isFielsdOptional(Struct1, index));
    index += 1;
    try expect(try isFielsdOptional(Struct1, index));
    index += 1;
    try expectError(error.IndexOutOfBounds, isFielsdOptional(Struct1, index));
}
