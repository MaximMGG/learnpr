const std = @import("std");
const Allocator = std.mem.Allocator;


pub fn LinkedList(comptime T: type) type {
    return struct {
        head: ?*Node = null,
        allocator: Allocator,

        const Self = @This();

        pub fn init(allocator: Allocator) Self {
            return .{
                .allocator = allocator,
            };
        }

        pub fn deinit(self: Self) void {
            var node = self.head;
            while(node) |n| {
                node = n.next;
                self.allocator.destroy(n);
            }
        }

        pub fn append(self: *Self, value: T) !void {
            const node = try self.allocator.create(Node);
            node.value = value;
            const h = self.head orelse {
                node.next = null;
                self.head = node;
                return;
            };
            node.next = h;
            self.head = node;
        }


        pub const Node = struct {
            value: T,
            next: ?*Node,
        };
    };

}
