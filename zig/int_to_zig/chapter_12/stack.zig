const std = @import("std");
const Allocator = std.mem.Allocator;



pub fn Stack(comptime T: type) type {
    return struct {
        items: []T,
        capacity: usize,
        len: usize,
        allocator: Allocator,
        const Self = @This();

        pub fn init(allocator: Allocator, capacity: usize) !Stack(T) {
            var buf = try allocator.alloc(T, capacity);

            return .{
                .capacity = capacity,
                .len = 0,
                .allocator = allocator,
                .items = buf[0..]
            };
        }

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.items);
        }

        pub fn push(self: *Self, val: T) !void {
            if (self.len + 1 == self.capacity) {
                self.capacity <<= 1;
                var buf = try self.allocator.alloc(T, self.capacity);
                @memcpy(buf[0..self.len + 1], self.items);
                self.allocator.free(self.items);
                self.items = buf;
            }
            self.items[self.len] = val;
            self.len += 1;
        }

        pub fn pop(self: *Self) T {
            const for_ret: T = self.items[self.len - 1];
            self.items[self.len - 1] = undefined;
            self.len -= 1;
            return for_ret;
        }
    };
}
