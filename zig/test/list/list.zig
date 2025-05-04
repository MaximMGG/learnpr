const std = @import("std");

pub fn List(T: type) type {
    return struct {
        const Self = @This();
        allocator: std.mem.Allocator,
        items: []T = &[_]T{},
        capasity: u32 = 0,

        pub fn init(allocator: std.mem.Allocator) Self {
            return Self{
                .allocator = allocator,
            };
        }

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.items);
        }

        pub fn append(self: *Self, item: T) !void {
            if (self.items.len == 0) {
                const buf = try self.allocator.alloc(T, 20);
                self.capasity = 20;
                self.items.ptr = buf.ptr;
                self.items.len = 0;
            }
            if (self.items.len == self.capasity) {
                try self.grow_capasity();
            }

            self.items[self.items.len] = item;
            self.items.len += 1;
        }

        fn grow_capasity(self: *Self) !void {
            var buf = try self.allocator.alloc(T, self.capasity << 1);
            @memcpy(buf[0..self.capasity], self.items);
            self.allocator.free(self.items);
            self.items.ptr = buf.ptr;
            self.items.len = self.capasity;
            self.capasity <<= 1;
        }
    };
}
