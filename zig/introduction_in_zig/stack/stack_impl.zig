const std = @import("std");


pub fn Stack(comptime T: type) type {
    return struct {
        data: []T = &[_]T{},
        capasity: usize = 20,
        allocator: std.mem.Allocator,

        const Self = @This();

        fn growCapasity(self: *Self) !void {
            self.capasity <<= 1;
            var new_data: []T = try self.allocator.alloc(T, self.capasity);
            @memcpy(new_data[0..self.data.len], self.data);
            new_data.len = self.data.len;
            self.allocator.free(self.data);
            self.data.ptr = new_data.ptr;
        }

        pub fn init(allocator: std.mem.Allocator) !Self {
            var tmp: []T = try allocator.alloc(T, 20);
            tmp.len = 0;

            return Self{
                .data = tmp,
                .allocator = allocator,
            };
        }

        pub fn deinit(self: *Self) void {
            self.data.len = self.capasity;
            self.allocator.free(self.data);
            self.capasity = undefined;
        }

        pub fn push(self: *Self, data: T) !void {
            if (self.data.len == self.capasity) {
                try self.growCapasity();
            }
            self.data.len += 1;
            self.data[self.data.len - 1] = data;
        }

        pub fn pop(self: *Self) T {
            const res: T = self.data[self.data.len - 1];
            self.data[self.data.len - 1] = undefined;
            self.data.len -= 1;

            return res;
        }
    };
}
