const std = @import("std");

fn getStruct(T: type, allocator: std.mem.Allocator) type {
    return struct {
        pub const S = struct {
            next: ?*S,
            data: T,
        };

        const def_size = 20;

        next: ?*S,
        data: *const []T = allocator.alloc(T, def_size),
    };
}

pub fn main() !void {
    const gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    const str = try getStruct(u32, alloc){ .next = null };
    std.debug.print("{any}\n", .{@TypeOf(str.next)});
}
