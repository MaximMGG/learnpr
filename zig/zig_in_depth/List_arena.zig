const std = @import("std");

pub fn List(comptime T: type) type {
    return struct {
        const Node = struct {
            data: T,
            next: ?*Node,

            fn init(allocator: std.mem.Allocator, data: T) !*Node {
                var node_ptr = try allocator.create(Node);
                node_ptr.data = data;
                node_ptr.next = null;

                return node_ptr;
            }
        };

        const Self = @This();

        arena: std.heap.ArenaAllocator,
        head: *Node,

        pub fn init(allocator: std.mem.Allocator, data: T) !Self {
            var list = Self{
                .arena = std.heap.ArenaAllocator.init(allocator),
                .head = undefined,
            };

            list.head = try Node.init(list.arena.allocator(), data);

            return list;
        }

        pub fn deinit(self: *Self) void {
            self.arena.deinit();
        }

        pub fn append(self: *Self, data: T) !void {
            var tail: *Node = self.head;
            while (tail.next) |ptr| tail = ptr;

            tail.next = try Node.init(self.arena.allocator(), data);
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
