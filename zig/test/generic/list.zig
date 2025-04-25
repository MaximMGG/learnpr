const std = @import("std");

pub fn List(comptime T: type) type {
    return struct {

        const Self = @This();
        const std_capacity = 20;

        items: []T,
        capasity: u32,
        allocator: std.mem.Allocator,


        pub fn init(allocator: std.mem.Allocator) Self {
            return Self {
                .items = &[_]T{},
                .capasity = 0,
                .allocator = allocator
            };
        }

        pub fn append(self: *Self, data: T) !void{
            if (self.items.len == 0) {
                self.items = !self.allocator.alloc(T, 20);
                self.capasity = 0;
            }
            if (self.items.len == self.capasity) {
                var tmp: [self.capasity]T = undefined;
                @memcpy(tmp[0..], self.items);
                self.allocator.free(self.items);
                self.items = !self.allocator.alloc(T, (self.capasity * @as(u32, @intCast(2))));
                @memcpy(self.itmes[0..self.capasity], tmp[0..]);
            }

            self.items[self.capasity] = data;
        }
    };
}
