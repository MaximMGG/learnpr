const std = @import("std");

pub fn List(comptime T: type) type {
    return struct {
        const Node = struct {
            allocator: std.mem.Allocator,
            data: T,
            next: ?*Node,

            fn init(allocator: std.mem.Allocator, data: T) !*Node {
                var node_ptr = try allocator.create(Node);
                node_ptr.allocator = allocator;
                node_ptr.data = data;
                node_ptr.next = null;

                return node_ptr;
            }

            fn deinit(self: *Node) void {
                if (self.next) |ptr| ptr.deinit();
                self.allocator.destroy(self);
            }
        };

        const Self = @This();

        allocator: std.mem.Allocator,
        head: *Node,

        pub fn init(allocator: std.mem.Allocator, data: T) !Self {
            return .{
                .allocator = allocator,
                .head = try Node.init(allocator, data),
            };
        }

        pub fn deinit(self: *Self) void {
            self.head.deinit();
        }

        pub fn append(self: *Self, data: T) !void {
            var tail: *Node = self.head;
            while (tail.next) |ptr| tail = ptr;

            tail.next = try Node.init(self.allocator, data);
        }

        pub fn lookup(self: Self, data: T) bool {
            var current: ?*Node = self.head;

            return while (current) |node_ptr| {
                if (node_ptr.data == data) return true;
                current = current.next;
            } else return false;
        }
    };
}
