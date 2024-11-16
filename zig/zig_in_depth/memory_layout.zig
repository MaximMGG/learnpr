const std = @import("std");
const print = std.debug.print;

const Extern = extern struct {
    a: u16,
    b: u64,
    c: u16,
};

const Normal = struct {
    a: u16,
    b: u64,
    c: u16,
};

const Packed = packed struct {
    a: u16,
    b: u64,
    c: u16,
};

extern "C" fn Ext_func(e: *Extern) void;

pub fn main() !void {
    printInfo(Extern);
    printInfo(Normal);
    printInfo(Packed);

    const w = Whole{
        .num = 0x1234,
    };

    const p: Parts = @bitCast(w);

    print("w.num: 0x{x}\n", .{w.num});
    print("p.half: 0x{x}\n", .{p.half});
    print("p.q3: 0x{x}\n", .{p.q3});
    print("p.q4: 0x{x}\n", .{p.q4});
}

fn printInfo(comptime T: type) void {
    print("size of {s}: {}\n", .{ @typeName(T), @sizeOf(T) });

    inline for (std.meta.fields(T)) |field| {
        print("   field {s} byte offset: {}\n", .{ field.name, @offsetOf(T, field.name) });
    }
    print("\n", .{});
}

const Whole = packed struct {
    num: u16,
};

const Parts = packed struct {
    half: u8,
    q3: u4,
    q4: u4,
};
